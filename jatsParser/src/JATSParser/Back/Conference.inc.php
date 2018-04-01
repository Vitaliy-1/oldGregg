<?php namespace JATSParser\Back;


use JATSParser\Back\AbstractReference as AbstractReference;

class Conference extends AbstractReference {

	/* @var $title string */
	private $title;

	/* @var $confName string */
	private $confName;

	/* @var $confLoc string */
	private $confLoc;

	/* @var $confDate string */
	private $confDate;

	public function __construct(\DOMElement $reference) {

		parent::__construct($reference);

		$this->title = $this->extractFromElement($reference, ".//source");
		$this->confName = $this->extractFromElement($reference, ".//conf-name");
		$this->confLoc = $this->extractFromElement($reference, ".//conf-loc");
		$this->confDate = $this->extractFromElement($reference, ".//conf-date");
	}

	/**
	 * @return string
	 */
	public function getId()
	{
		return $this->id;
	}

	/**
	 * @return string
	 */
	public function getTitle(): string
	{
		return $this->title;
	}

	/**
	 * @return array
	 */
	public function getAuthors(): array
	{
		return $this->authors;
	}


	/**
	 * @return array
	 */
	public function getEditors(): array
	{
		return $this->editors;
	}

	/**
	 * @return string
	 */
	public function getYear(): string
	{
		return $this->year;
	}

	/**
	 * @return string
	 */
	public function getUrl(): string
	{
		return $this->url;
	}

	/**
	 * @return string
	 */
	public function getConfDate(): string
	{
		return $this->confDate;
	}

	/**
	 * @return string
	 */
	public function getConfLoc(): string
	{
		return $this->confLoc;
	}

	/**
	 * @return string
	 */
	public function getConfName(): string
	{
		return $this->confName;
	}

	/**
	 * @return array
	 */
	public function getPubIdType(): array
	{
		return $this->pubIdType;
	}
}

