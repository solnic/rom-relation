# Tests

 * Add missing unit specs (see pending + mutant output)
 * Replace veritas engine in unit specs with the in_memory one
 * Add shared specs for all engines (both unit and integration)

# Mapper

 * Replace anonymous mapper classes with constants
 * Integrate with dm-session

# Relation Graph & Engines

 * Finish aliasing (aka the jersey thing)
 * [arel] finish CRUD interface
 * [arel] add coercion support for drivers that need it (we can use Virtus::Coercion for that)
 * [arel] add logger support
 * [arel] add support for composite keys

# General

 * Extract veritas and arel engines into separate projects
 * Add missings docs
 * Setup rake ci and make it pass (requires mutant coverage)
