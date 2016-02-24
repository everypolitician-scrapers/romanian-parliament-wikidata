#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://ro.wikipedia.org/wiki/Legislatura_2012-2016_(Camera_Deputaților)',
  xpath: '//table[.//tr[th[.="Partid"]]]//tr[td]//td[2]//a[not(@class="new")]/@title',
)

EveryPolitician::Wikidata.scrape_wikidata(names: { ro: names }, output: false)
