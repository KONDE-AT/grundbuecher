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
    <acdh:TopCollection rdf:about="https://id.acdh.oeaw.ac.at/grundbuecher-facs">
        <acdh:hasTitle xml:lang="de">Faksimiles des Darlehensbuch Satzbuch CD (1438-1473)</acdh:hasTitle>
        <acdh:hasDescription xml:lang="de">Diese Sammlung enthält die Scans des Darlehensbuch Satzbuch CD (1438-1473) (Signatur WStLA 2.1.2.1.B1.34), angefertigt vom Wiener Stadt- und Landesarchiv</acdh:hasDescription>
        <acdh:hasCoverageStartDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">1438-01-01</acdh:hasCoverageStartDate>
        <acdh:hasCoverageEndDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">1473-12-31</acdh:hasCoverageEndDate>
        <acdh:hasCreator rdf:resource="https://d-nb.info/gnd/2060831-7"/>
        <acdh:hasRightsHolder rdf:resource="https://d-nb.info/gnd/2060831-7"/>
        <acdh:hasOwner rdf:resource="https://d-nb.info/gnd/2060831-7"/>
        <acdh:hasLicensor rdf:resource="https://d-nb.info/gnd/2060831-7"/>
        <acdh:hasOaiSet rdf:resource="https://vocabs.acdh.oeaw.ac.at/archeoaisets/kulturpool"/>
        <acdh:hasSubject xml:lang="de">Grundbuch</acdh:hasSubject>
        <acdh:hasSubject xml:lang="de">Geschichte</acdh:hasSubject>
        <acdh:hasContact rdf:resource="https://d-nb.info/gnd/2060831-7"/> 
        <acdh:hasDepositor rdf:resource="https://d-nb.info/gnd/1043833846"/>
        <acdh:hasCurator rdf:resource="https://d-nb.info/gnd/1043833846"/>
        <acdh:hasRelatedDiscipline rdf:resource="https://vocabs.acdh.oeaw.ac.at/oefosdisciplines/601"/> <!-- Geschichte, Archäologie -->
        <acdh:hasSpatialCoverage rdf:resource="https://www.geonames.org/2761367"/>
        <acdh:hasMetadataCreator rdf:resource="https://d-nb.info/gnd/1043833846"/>
        <acdh:hasLicense rdf:resource="https://vocabs.acdh.oeaw.ac.at/archelicenses/cc-by-nc-nd-4-0"/>
    </acdh:TopCollection>
    <acdh:Organisation rdf:about="https://d-nb.info/gnd/2060831-7">
        <acdh:hasTitle xml:lang="und">Wiener Stadt- und Landesarchiv</acdh:hasTitle>
    </acdh:Organisation>
{
  for $x in collection($app:data)//img/text()
    let $id := $x
    let $arche_id := "https://id.acdh.oeaw.ac.at/grundbuecher-facs/"||$id
    let $title := replace(replace($x, '.jpg', ''), '_', ' ')
    let $docs := collection($app:data)//tei:TEI[.//tei:graphic[@url=$id]]
    where $id != ""

    return
    <acdh:Resource rdf:about="{$arche_id}">
      <acdh:isPartOf rdf:resource="https://id.acdh.oeaw.ac.at/grundbuecher-facs"/>
      <acdh:hasTitle xml:lang="de">Faksimile von {$title}</acdh:hasTitle>
       <acdh:hasCoverageStartDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">1438-01-01</acdh:hasCoverageStartDate>
        <acdh:hasCoverageEndDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">1473-12-31</acdh:hasCoverageEndDate>
        <acdh:hasCreator rdf:resource="https://d-nb.info/gnd/2060831-7"/>
        <acdh:hasRightsHolder rdf:resource="https://d-nb.info/gnd/2060831-7"/>
        <acdh:hasOwner rdf:resource="https://d-nb.info/gnd/2060831-7"/>
        <acdh:hasLicensor rdf:resource="https://d-nb.info/gnd/2060831-7"/>
        <acdh:hasOaiSet rdf:resource="https://vocabs.acdh.oeaw.ac.at/archeoaisets/kulturpool"/>
        <acdh:hasSubject xml:lang="de">Grundbuch</acdh:hasSubject>
        <acdh:hasSubject xml:lang="de">Geschichte</acdh:hasSubject>
        <acdh:hasContact rdf:resource="https://d-nb.info/gnd/2060831-7"/> 
        <acdh:hasDepositor rdf:resource="https://d-nb.info/gnd/1043833846"/>
        <acdh:hasCurator rdf:resource="https://d-nb.info/gnd/1043833846"/>
        <acdh:hasRelatedDiscipline rdf:resource="https://vocabs.acdh.oeaw.ac.at/oefosdisciplines/601"/> <!-- Geschichte, Archäologie -->
        <acdh:hasSpatialCoverage rdf:resource="https://www.geonames.org/2761367"/>
        <acdh:hasMetadataCreator rdf:resource="https://d-nb.info/gnd/1043833846"/>
        <acdh:hasCategory rdf:resource="https://vocabs.acdh.oeaw.ac.at/archecategory/image"/>
        <acdh:hasLicense rdf:resource="https://vocabs.acdh.oeaw.ac.at/archelicenses/cc-by-nc-nd-4-0"/>
        <acdh:hasFormat>image/jpeg</acdh:hasFormat>
        {
            for $doc in $docs            
            let $doc-id := data($doc/@xml:base)||"/"||data($doc/@xml:id)
            return
                <acdh:isSourceOf rdf:resource="{$doc-id}"/>
         }
    </acdh:Resource>
}
</rdf:RDF>
return $result
