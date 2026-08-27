-- Section 4 Q5 - Implicit vs Explicit vs Parameterised Cursor

SET SERVEROUTPUT ON;

/*
============================================================================
COMPARISON: IMPLICIT vs EXPLICIT (SIMPLE) vs PARAMETERISED CURSOR
============================================================================

| Heading                        | Implicit Cursor          | Explicit (Simple) Cursor      | Parameterised Cursor              |
|---------------------------------|---------------------------|-------------------------------|-------------------------------------|
| Who declares it                | Oracle declares it        | The programmer declares it    | The programmer declares it, with   |
|                                 | automatically for every   | in the DECLARE section with   | parameters in the header, e.g.     |
|                                 | SQL DML statement (SELECT | a name, e.g.                  | CURSOR c (p_x VARCHAR2) IS ...     |
|                                 | INTO, INSERT, UPDATE,     | CURSOR c IS SELECT ...        |                                      |
|                                 | DELETE) - referred to as  |                                |                                      |
|                                 | SQL%FOUND, SQL%ROWCOUNT   |                                |                                      |
|                                 | etc.                      |                                |                                      |
|---------------------------------|---------------------------|--------------------------------|--------------------------------------|
| Who opens and closes it         | Oracle opens and closes   | The programmer must OPEN,     | The programmer must OPEN (passing   |
|                                 | it automatically -         | FETCH and CLOSE it explicitly | the required arguments), FETCH and  |
|                                 | invisible to the coder     | (or use a cursor FOR loop,     | CLOSE it explicitly (or use a       |
|                                 |                            | which auto-opens/closes)       | parameterised cursor FOR loop)      |
|---------------------------------|---------------------------|--------------------------------|--------------------------------------|
| Can it be reused with           | No - it is tied to one     | No - the query is fixed at     | Yes - the SAME cursor can be        |
| different values?               | specific DML statement;    | declaration time; to query     | reopened multiple times with        |
|                                 | Oracle creates a NEW       | different data you would need  | DIFFERENT argument values each      |
|                                 | implicit cursor for each   | a different cursor or rely on  | time it is opened, e.g. once for    |
|                                 | statement execution        | bind variables in the query    | 'Database' and once for             |
|                                 |                            |                                 | 'Programming'                       |
|---------------------------------|---------------------------|--------------------------------|--------------------------------------|
| One situation where it is the   | A simple SELECT INTO       | Fetching and processing a      | Building a single reusable report   |
| best choice                     | that returns exactly one   | fixed multi-row result set     | cursor (e.g. "all books in category |
|                                 | row, e.g. fetching one     | row-by-row when the query      | X") that will be called repeatedly  |
|                                 | employee's salary by ID    | never changes, e.g. printing   | with different category names,      |
|                                 |                            | every row of a report          | member IDs, or date ranges          |
============================================================================
*/