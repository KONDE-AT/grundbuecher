xquery version "3.1";

import module namespace app="http://www.digital-archiv.at/ns/templates" at "../modules/app.xql";
import module namespace request="http://exist-db.org/xquery/request";

declare namespace acdh="https://vocabs.acdh.oeaw.ac.at/schema#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace tei = "http://www.tei-c.org/ns/1.0";


declare option output:method "xml";
declare option output:media-type "application/xml";

let $result := <rdf:RDF xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:acdh="https://vocabs.acdh.oeaw.ac.at/schema#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xml:base="https://id.acdh.oeaw.ac.at/">
{
  for $x in distinct-values(collection($app:editions)//tei:graphic/data(@url))
    let $id := $x
    let $arche_id := "https://id.acdh.oeaw.ac.at/grundbuecher/facs/"||$id
    let $source_of := distinct-values(collection($app:editions)/tei:TEI[.//tei:graphic[./@url=$id]]/@xml:id)
    where $id != ""

    return
    <acdh:Resource rdf:about="{$arche_id}">
      <acdh:isPartOf rdf:resource="https://id.acdh.oeaw.ac.at/grundbuecher/facs"/>
      <acdh:hasTitle xml:lang="de">{$id}</acdh:hasTitle>
      <acdh:hasCreator rdf:resource="https://d-nb.info/gnd/2060831-7"/>
      {
        for $x in $source_of
          return
            <acdh:isSourceOf rdf:resource="https://id.acdh.oeaw.ac.at/grundbuecher/editions/{$x}"/>
      }
      <acdh:hasRightsHolder rdf:resource="https://d-nb.info/gnd/2060831-7"/>
      <acdh:hasOwner rdf:resource="https://d-nb.info/gnd/2060831-7"/>
      <acdh:hasLicensor rdf:resource="https://d-nb.info/gnd/2060831-7"/>
      <acdh:hasLicense rdf:resource="https://vocabs.acdh.oeaw.ac.at/archelicenses/cc-by-nc-nd-4-0"/>
      <acdh:hasCategory rdf:resource="https://vocabs.acdh.oeaw.ac.at/archecategory/image"/>
      <acdh:hasOaiSet rdf:resource="https://vocabs.acdh.oeaw.ac.at/archeoaisets/kulturpool"/>
      <acdh:hasMetadataCreator rdf:resource="https://d-nb.info/gnd/1043833846"/>
      <acdh:hasDepositor rdf:resource="https://d-nb.info/gnd/1043833846"/>
    </acdh:Resource>
}
</rdf:RDF>
return $result
