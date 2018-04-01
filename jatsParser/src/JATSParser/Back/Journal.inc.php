<?php namespace JATSParser\Back;

use JATSParser\Back\AbstractReference as AbstractReference;

class Journal extends AbstractReference
{

	/* @var $title string */
	private $title;

	/* @var $journal string */
	private $journal;

	/* @var $volume string */
	private $volume;

	/* @var $issue string */
	private $issue;

	/* @var $fpage string */
	private $fpage;

	/* @var $lpage string */
	private $lpage;

	public function __construct(\DOMElement $reference)
	{

		parent::__construct($reference);

		$this->title = $this->extractFromElement($reference, ".//article-title[1]");
		$this->journal = $this->extractFromElement($reference, ".//source[1]");
		$this->volume = $this->extractFromElement($reference, ".//volume[1]");
		$this->issue = $this->extractFromElement($reference, ".//issue[1]");
		$this->fpage = $this->extractFromElement($reference, ".//fpage[1]");
		$this->lpage = $this->extractFromElement($reference, ".//lpage[1]");
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
	public function getFpage(): string
	{
		return $this->fpage;
	}

	/**
	 * @return string
	 */
	public function getLpage(): string
	{
		return $this->lpage;
	}

	/**
	 * @return string
	 */
	public function getIssue(): string
	{
		return $this->issue;
	}

	/**
	 * @return string
	 */
	public function getVolume(): string
	{
		return $this->volume;
	}

	/**
	 * @return array
	 */
	public function getPubIdType(): array
	{
		return $this->pubIdType;
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
	public function getJournal(): string
	{
		return $this->journal;
	}
}