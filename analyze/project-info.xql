xquery version "3.1";
declare namespace expath="http://expath.org/ns/pkg";
declare namespace repo="http://exist-db.org/xquery/repo";
import module namespace app="http://www.digital-archiv.at/ns/templates" at "../modules/app.xql";
import module namespace config="http://www.digital-archiv.at/ns/config" at "modules/config.xqm";
declare option exist:serialize "method=json media-type=text/javascript content-type=application/json";


let $purpose_de := "Ziel von"|| $app:projectName|| "ist die Publikation von Forschungsdaten."
let $purpose_en := "The purpose of" || $app:projectName ||" is the publication of research data."
let $map := map{
    "title": $app:projectName,
    "subtitle": "Digital Scholarly Editions Base Application",
    "author": $app:authors,
    "description": $app:description,
    "github": "https://github.com/KONDE-AT/grundbuecher",
    "purpose_de": $purpose_de,
    "purpose_en": $purpose_en,
    "app_type": "digital-edition",
    "base_tech": "eXist-db",
    "framework": "Digital Scholarly Editions Base Application"
}
return 
        $map