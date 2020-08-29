xquery version "3.1";

(:~
 : This module provides a couple of helper functions used in the post-install.xql
 : @author peter.andorfer@oeaw.ac.at
:)

module namespace enrich="http://www.digital-archiv.at/ns/enrich";

import module namespace app="http://www.digital-archiv.at/ns/templates" at "../modules/app.xql";
import module namespace config="http://www.digital-archiv.at/ns/config" at "../modules/config.xqm";

declare namespace functx = "http://www.functx.com";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace acdh="https://vocabs.acdh.oeaw.ac.at/schema#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace util = "http://exist-db.org/xquery/util";

(:~
 : creates RDF Metadata describing the applications basic collection structure
 :
 : @param $archeURL The Top-Collection URL, e.g. https://id.acdh.oeaw.ac.at/grundbuecher/{top-col-name}
 : @param $colName The name of the data-collection to process, e.g. 'editions'
 : @return An ARCHE RDF describing the collections
:)

declare function enrich:add_base_and_xmlid($archeURL as xs:string, $colName as xs:string) {
      let $collection := $app:data||'/'||$colName
      let $all := collection($collection)//tei:TEI
      let $base_url := $archeURL||$colName

    for $x in $all
        let $collectionName := util:collection-name($x)
        let $currentDocName := util:document-name($x)
        let $neighbors := app:doc-context($collectionName, $currentDocName)
        let $xml_id := util:document-name($x)
        let $base := update insert attribute xml:base {$base_url} into $x
        let $currentID := update insert attribute xml:id {$currentDocName} into $x
        let $prev := if($neighbors[1])
        then
            update insert attribute prev {string-join(($base_url, $neighbors[1]), '/')} into $x
        else
            ()
    let $next := if($neighbors[3])
        then
            update insert attribute next {string-join(($base_url, $neighbors[3]), '/')}into $x
        else
            ()
        return
          <result base="{$base_url}">
            <collectionName>{$collectionName}</collectionName>
            <currentDocName>{$currentDocName}</currentDocName>
            <xml_id>{$xml_id}</xml_id>
          </result>

};
