#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

query = 'SELECT DISTINCT ?item { ?item wdt:P39/wdt:P279* wd:Q17556530 }'
ids = EveryPolitician::Wikidata.sparql(query)

names = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://ro.wikipedia.org/wiki/Legislatura_2012-2016_(Camera_Deputaților)',
  xpath: '//table[.//tr[th[.="Partid"]]]//tr[td]//td[2]//a[not(@class="new")]/@title'
)

by_cat = WikiData::Category.new('Categorie:Deputați români 2012-2016', 'ro').member_titles

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { ro: names | by_cat })
