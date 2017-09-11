xquery version "1.0-ml";

module namespace securer = "http://marklogic.com/rest-api/resource/secure-pii";

import module namespace op = "http://marklogic.com/optic" at "/MarkLogic/optic.xqy";

import module namespace sec="http://marklogic.com/xdmp/security"
at "/MarkLogic/security.xqy";

declare namespace rapi="http://marklogic.com/rest-api";


declare %rapi:transaction-mode("update") function securer:get(
    $context as map:map,
    $params as map:map
) as document-node()?
{
    let $es := op:prefixer("http://marklogic.com/entity-services#")
    let $c := op:prefixer("http://marklogic.com/entity-services/example-els/Secure-0.0.1/")
    let $piri := op:col("property-iri")
    let $type := op:col("type")
    let $pname := op:col("pname")
    let $role := op:col("role")

    let $pii-columns :=
        op:from-triples((
            op:pattern(op:col("type-iri"), $es("property"), $piri),
            op:pattern(op:col("type-iri"), $es("title"), $type),
            op:pattern($piri, $es("secure-read-with-role"), $role),
            op:pattern($piri, $es("title"), $pname)
        ))=>op:select(($type, $pname, $role))
        =>op:result()


    let $protect := function($type, $pname, $role) {
        function() {
            sec:protect-path("//envelope/instance/" || $type || "/" || $pname,
                (),
                (xdmp:permission($role, "read")))
        }
    }

    let $securing-functions :=
        $pii-columns !  $protect(.=>map:get("type"), .=>map:get("pname"), .=>map:get("role"))

    return
        document {
            for $fn in $securing-functions
            return
                xdmp:invoke-function($fn,
                    map:map()
                    =>map:with("database", xdmp:database("Security")))
        }
};
