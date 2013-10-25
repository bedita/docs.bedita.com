<?php

class PagesController extends FrontendController {

	var $helpers = array("BeFront");
	var $uses = array() ;

	/**
	 * load common data, for all frontend pages...
	 */
	protected function beditaBeforeFilter() {
		if ($this->RequestHandler->isAjax()) {
			Configure::write('debug', 0);
			$this->layout = "ajax";
			$this->set("isAjax", true);
		}

		// uncomment to use ctp file instead of tpl file for templates
		$this->set('feedNames', $this->Section->feedsAvailable(Configure::read("frontendAreaId")));
		$this->set('menu', $this->loadSectionsTree(Configure::read("frontendAreaId")));
	}

	protected function beditaBeforeRender()	{
		// when content is requested
		if (!empty($this->viewVars["section"]["contentRequested"]) && !empty($this->viewVars["section"]["childContents"])) {
			for ($i=0; $i < count($this->viewVars["section"]["childContents"]); $i++) {
				if ($this->viewVars["section"]["currentContent"]["id"] == $this->viewVars["section"]["childContents"][$i]["id"]) {
					if ($i > 0) {
						$this->set("previousItem", $this->viewVars["section"]["childContents"][$i-1]);
					}
					if (!empty($this->viewVars["section"]["childContents"][$i+1])) {
						$this->set("nextItem", $this->viewVars["section"]["childContents"][$i+1]);
					}
					break;
				}
			}
		}


		// get used categories in current page (and sort)
		if (!empty($this->viewVars["section"]["childContents"])) {
			$pageCategories = array();
			$morePageCategories = array();
			foreach ($this->viewVars["section"]["childContents"] as $obj) {
				if (!empty($obj["Category"])) {
					foreach ($obj["Category"] as $category) {
						if ( !in_array($category, $pageCategories) && strstr($category["name"], "bedita") ) {
							$pageCategories[] = $category;
						} else if (!in_array($category, $morePageCategories) && !strstr($category["name"], "bedita") ) {
							$morePageCategories[] = $category;
						}
					}
				}
			}

			usort($pageCategories, array('PagesController', 'sortCategories'));
			usort($morePageCategories, array('PagesController', 'sortCategories'));
			$pageCategories = array_merge($pageCategories, $morePageCategories);
			$this->set('pageCategories', $pageCategories);
		}


		// load tags
		if (empty($this->viewVars['listTags'])) {
			$this->loadTags(null, true, true, 20);
		}

		// get categories used in tag pages
		if(!empty($this->viewVars["tag"]["items"])) {
			$pageCategories = array();
			$morePageCategories = array();
			foreach ($this->viewVars["tag"]["items"] as $obj) {
				if (!empty($obj["Category"])) {
					foreach ($obj["Category"] as $category) {
						if ( !in_array($category, $pageCategories) && strstr($category["name"], "bedita") ) {
							$pageCategories[] = $category;
						} else if (!in_array($category, $morePageCategories) && !strstr($category["name"], "bedita") ) {
							$morePageCategories[] = $category;
						}
					}
				}
			}

			usort($pageCategories, array('PagesController', 'sortCategories'));
			usort($morePageCategories, array('PagesController', 'sortCategories'));
			$pageCategories = array_merge($pageCategories, $morePageCategories);
			$this->set('pageCategories', $pageCategories);
		}

		// put in history only content
		if (Configure::read("staging") || empty($this->viewVars["section"]["contentRequested"])) {
			$this->historyItem = null;
		}
	}


	public function homePage () {
		foreach ($this->viewVars['menu'] as $key => $value)	{

			$options = array(
				"filter" => array(
					'object_type_id' => Configure::read("obejctTypes.leafs.id")
				),
				"order" => "Tree.priority DESC, BEObject.created",
				"dir" => 0,
				"dim" => Configure::read("homePage.totalItemsForSection")
			);
			$menu = $this->loadSectionObjects($value['id'], $options);

			if (!empty($menu["childContents"]))	{

				// most read
				$historyModel = ClassRegistry::init("History");
				// exclude from most read the ids already loaded
				$idsToExclude = Set::extract("/childContents/id", $menu);

				$mostRead = $historyModel->find("all", array(
					"conditions" =>  array(
						"BEObject.status" => $this->getStatus(),
						"Tree.parent_id" => $value["id"],
						"History.area_id" => $this->publication["id"],
						"History.object_id NOT" => $idsToExclude
					),
					"fields" => array("COUNT(History.object_id) AS countrows", "object_id"),
					"group" => "History.object_id",
					"order" => "countrows DESC",
					"limit" => Configure::read("homePage.mostReadItems"),
					"contain" => array("BEObject"),
					"joins" => array(
						array(
							"table" => "trees",
							"alias" => "Tree",
							"type" => "LEFT",
							"conditions" => array(
								"History.object_id = Tree.id"
							)
						)
					)
				));

				$mostReadObjects = array();
				foreach ($mostRead as $ms) {
					$obj = $this->loadObj($ms["History"]["object_id"]);
					$obj['canonicalPath'] = $value["canonicalPath"] . "/" . $obj["nickname"];
					$mostReadObjects[] = $obj;
				}

				$this->viewVars['menu'][$key]["mostRead"] = $mostReadObjects;

				// adjust number of section's children to show
				$realMostReadItems = count($mostReadObjects);
				if ($realMostReadItems > 0) {
					array_splice($menu["childContents"], -$realMostReadItems);
				}

				$this->viewVars['menu'][$key]["childContents"] = $menu["childContents"];
			}
		}
	}

	private static function sortCategories($e1, $e2) {
		return strcasecmp($e2["name"], $e1["name"]);
	}

	public function showMedia($nickname) {
		$obj = $this->loadObjByNick($nickname);
		if (in_array($obj["object_type_id"], Configure::read("objectTypes.multimedia.id"))) {
			$this->set("media", $obj);
		}
		if (!empty($this->params["form"]["mediaWidth"])) {
			$this->set("mediaWidth", $this->params["form"]["mediaWidth"]);
		}
	}

	public function glossary($nickname = null) {
		if (!empty($this->params['form']['title'])) {
			$definitionTerm = ClassRegistry::init('DefinitionTerm')->findByWord($this->params['form']['title'], array(
				"conditions" => array(
					"BEObject.status" => $this->getStatus()
				)
			));
			$this->set('definitionTerm', $definitionTerm);
		} elseif (!empty($nickname)) {
			$definitionTerm = ClassRegistry::init('DefinitionTerm')->find("first", array(
				"conditions" => array(
					"BEObject.status" => $this->getStatus(),
					"BEObject.nickname" => $nickname
				)
			));
			$this->set('definitionTerm', $definitionTerm);
		} else {
			$glossary = ClassRegistry::init('DefinitionTerm')->find("all", array(
				"conditions" => array(
					"object_type_id" => Configure::read("objectTypes.definition_term.id"),
					"status" => $this->getStatus()
				),
				"contain" => array(),
				"order" => "title ASC"
			));
			$this->set('glossary', $glossary);
		}
	}

	/**
	 * Bato: la sto usando per fare dei test
	 * @param string $type, set to "json" to return results in json
	 */
	public function search($type = null) {
		parent::search();
		if ($type == "json") {
			header("Content-Type: application/json");
			$this->view = 'View';
			$this->layout = null;
			$this->action = "json";
			$this->set("data", $this->viewVars["searchResult"]);
		} else {
			if (!empty($this->viewVars["searchResult"])) {
				foreach ($this->viewVars["searchResult"]["items"] as &$item) {
					$item = $this->loadObj($item["id"]);
					$this->setCanonicalPath($item);
				}
			}
		}
	}

}
