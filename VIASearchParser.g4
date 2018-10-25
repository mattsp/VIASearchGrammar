parser grammar VIASearchParser;

options {
	tokenVocab = VIASearchLexer;
}

searchQuery: searchElements;

searchElements: searchElement*;

searchElement: searchElementTag | searchElementRaw;

searchElementTag: START_TAG TAG_ATTRIBUTE END_TAG;

searchElementRaw: TEXT;
