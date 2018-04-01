<?php namespace JATSParser\Body;

use JATSParser\Body\JATSElement as JATSElement;
use JATSParser\Body\Document as Document;
use JATSParser\Body\Cell as Cell;

class Row implements JATSElement {

	/* @var $content array */
	private $content;

	/* @var $type int;
	 * points the row location inside DOM table tree
	 * 1 - head, 2 - body, 3 - child of table
	 */
	private $type;

	public function __construct(\DOMElement $rowNode) {
		$rowParents = $rowNode->parentNode;
		switch ($rowParents->nodeName) {
			case "thead":
				$this->type = 1;
				break;
			case "tbody":
				$this->type = 2;
				break;
			case "table":
				$this->type = 3;
				break;
			default:
				$this->type = 3;
		}

		$xpath = Document::getXpath();
		$content = array();
		$cellNodes = $xpath->query(".//td|.//th", $rowNode);
		foreach ($cellNodes as $cellNode) {
			$cell = new Cell($cellNode);
			$content[] = $cell;
		}
		$this->content = $content;
	}

	public function getContent(): array {
		return $this->content;
	}

	public function getType(): int {
		return $this->type;
	}
}