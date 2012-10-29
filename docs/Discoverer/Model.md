Model
=====

Model is a class to be inherited in every Fetcher Model.

It automagically:

* Includes Virtus
* Adds the `:_id` attribute
* Provides a flexible constructor on top of Virtus
* Defines `#from` and `#to` as [Discoverer Methods](http://xaviervia.com.ar/patterns/discoverer-method) for Readers and Writers