#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

query = 'SELECT DISTINCT ?item { ?item wdt:P39/wdt:P279* wd:Q17556530 }'
ids = EveryPolitician::Wikidata.sparql(query)

wd2012 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://ro.wikipedia.org/wiki/Legislatura_2012-2016_(Camera_Deputa%C8%9Bilor)',
  xpath: '//table[.//tr[th[contains(.,"Partid")]]]//tr[td]//td[2]//a[not(@class="new")]/@title',
  as_ids: true,
)

wd2016 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://ro.wikipedia.org/wiki/Legislatura_2016-2020_(Camera_Deputa%C8%9Bilor)',
  xpath: '//table[.//tr[th[contains(.,"Grup parl")]]]//tr[td]//td[2]//a[not(@class="new")]/@title',
  as_ids: true,
)

cat_2012 = WikiData::Category.new('Categorie:Deputați români 2012-2016', 'ro').member_titles
cat_2016 = WikiData::Category.new('Categorie:Deputați români 2016-2020', 'ro').member_titles

EveryPolitician::Wikidata.scrape_wikidata(ids: ids | wd2012 | wd2016, names: { ro: cat_2012|cat_2016 })
