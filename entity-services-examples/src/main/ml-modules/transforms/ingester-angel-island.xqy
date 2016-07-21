xquery version "1.0-ml";
module namespace ingester = "http://marklogic.com/rest-api/transform/ingester-angel-island";

import module namespace race = "http://grechaw.github.io/entity-types#Race-0.0.2"
    at "/ext/Race-0.0.2.xqy";

import module namespace sem = "http://marklogic.com/semantics" at "/MarkLogic/semantics.xqy";

declare function ingester:transform(
    $context as map:map,
    $params as map:map,
    $body as document-node()
) as document-node()?
{
    let $uri := map:get($context, "uri")
    let $_ := xdmp:log(("Procesing URI " || $uri))
    let $_ :=
        if (contains($uri, "angel-island"))
        then xdmp:document-insert(
                "/runs/" || $uri,
                race:instance-to-envelope(
                race:extract-instance-Angel-Island(doc($uri))),
                xdmp:default-permissions(), ("run-envelopes", "angel-island"))
        else ()
    return document { " " }
};
