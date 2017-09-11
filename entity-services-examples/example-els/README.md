Element Level Security Example (example-els)
--------------------------------------------

Element-Level Security is a capability in MarkLogic since 9.0-1.
Under normal circumstances, permissions in MarkLogic is managed at the level of
the document.  That is to say, if a particular user has the permission to read
a particular document, then they can read the entire thing.  Since 9.0-1 one
can configure a secondary level of security based on XPath expressions, such
that, depending on permissions, one might be able to read or query only certain
parts of a document.

Element-Level Security is not directly integrated with Entity Services.
However, since a model determines document structure, the configuration for
element level security should be simple to derive given policies applied to
parts of a model.

In this example we provide two security scenarios.  The first has a document structure like this:

...


The model descriptor is quite straightforward.  We've added however two triples
to the document in order to capture the notion that some properties in this
model are indeed 

