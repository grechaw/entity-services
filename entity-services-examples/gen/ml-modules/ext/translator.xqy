xquery version "1.0-ml";
module namespace race-from-race 
    = "http://grechaw.github.io/entity-types#Race-0.0.2-from-Race-0.0.1";

import module namespace es = "http://marklogic.com/entity-services" 
    at "/MarkLogic/entity-services/entity-services.xqy";

(: This module was generated by MarkLogic Entity Services.                          :)
(: Its purpose is to create instances of entity types                               :)
(: defined in                                                                       :)
(: Race, version 0.0.2                                                              :)
(: from documents that were persisted according to model                            :)
(: Race, version 0.0.1                                                              :)
(:                                                                                  :)
(: Modification History:                                                            :)
(: Generated at timestamp: 2016-07-30T08:43:32.509884-07:00                         :)
(:   Persisted by AUTHOR                                                            :)
(:   Date: DATE                                                                     :)


(:~
 : Creates a map:map instance representation of the target entity type
 : from a document that contains the source entity instance.
 : @param $source-node  A document or node that contains data conforming to the
 : source entity type
 : @return A map:map instance that holds the data for this entity type.
 :)
declare function race-from-race:convert-instance-Race(
    $source-node as node()
) as map:map
{
 json:object()
(: The following line identifies the type of this instance.  Do not change it.      :)
 =>map:with('$type', 'Race')
(: The following lines are generated from the 'Race' entity type.                   :)
 =>   map:with('name',                   xs:string($source-node/Race/name))
 (: The following property was missing from the source type                          :)
=>es:optional('raceCategory',           xs:string( () ))
 =>es:optional('comprisedOfRuns',        race-from-race:extract-array($source-node/Race/comprisedOfRuns, function($path) { json:object()=>map:with('$type', 'Run')=>map:with('$ref', $path/Run/text() ) }))
 =>es:optional('wonByRunner',            function($path) { json:object()=>map:with('$type', 'Runner')=>map:with('$ref', $path/Runner/text() ) }($source-node/Race/wonByRunner))
 =>   map:with('courseLength',           xs:decimal($source-node/Race/courseLength))

};
    
(:~
 : Creates a map:map instance representation of the target entity type
 : from a document that contains the source entity instance.
 : @param $source-node  A document or node that contains data conforming to the
 : source entity type
 : @return A map:map instance that holds the data for this entity type.
 :)
declare function race-from-race:convert-instance-Run(
    $source-node as node()
) as map:map
{
 json:object()
(: The following line identifies the type of this instance.  Do not change it.      :)
 =>map:with('$type', 'Run')
(: The following lines are generated from the 'Run' entity type.                    :)
 =>   map:with('id',                     xs:string($source-node/Run/id))
 =>   map:with('date',                   xs:date($source-node/Run/date))
 =>   map:with('distance',               xs:decimal($source-node/Run/distance))
 =>es:optional('distanceLabel',          xs:string($source-node/Run/distanceLabel))
 =>es:optional('duration',               xs:dayTimeDuration($source-node/Run/duration))
 =>   map:with('runByRunner',            function($path) { json:object()=>map:with('$type', 'Runner')=>map:with('$ref', $path/Runner/text() ) }($source-node/Run/runByRunner))

};
    
(:~
 : Creates a map:map instance representation of the target entity type
 : from a document that contains the source entity instance.
 : @param $source-node  A document or node that contains data conforming to the
 : source entity type
 : @return A map:map instance that holds the data for this entity type.
 :)
declare function race-from-race:convert-instance-Runner(
    $source-node as node()
) as map:map
{
 json:object()
(: The following line identifies the type of this instance.  Do not change it.      :)
 =>map:with('$type', 'Runner')
(: The following lines are generated from the 'Runner' entity type.                 :)
 =>   map:with('name',                   xs:string($source-node/Runner/name))
 =>   map:with('age',                    xs:decimal($source-node/Runner/age))
 =>es:optional('gender',                 xs:string($source-node/Runner/gender))

};
    

(:~
 : This function includes an array if there are items to put in it.
 : If there are no such items, then it returns an empty sequence.
 : TODO EA-4? move to es: module
 :)
declare function race-from-race:extract-array(
    $path-to-property as item()*,
    $fn as function(*)
) as json:array?
{
    if (empty($path-to-property))
    then ()
    else json:to-array($path-to-property ! $fn(.))
};



