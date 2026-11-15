# Yars

```
db    db  .d8b.  d8888b. .d8888.
`8b  d8' d8' `8b 88  `8D 88'  YP
 `8bd8'  88ooo88 88oobY' `8bo.
   88    88~~~88 88`8b     `Y8b.
   88    88   88 88 `88. db   8D
   YP    YP   YP 88   YD `8888Y'
```

Yars is a modern, formalised YARA signature ruleset built for CI/CD.

## Repository Structure

All signatures are contained with the ``yara`` directory, all rules are nested within directories which describe the classification of the samples they match. 

| Directory Name | Description                                                                                                                                              |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Sourcing       | Signatures for the sole purpose of sourcing and understanding new samples or formats, they are naturally FP prone so I consider them a separate category |
| Exploit        | Signatures for n-day exploit payloads and PoCs                                                                                                           |
| HackTool       | Signatures for HackTools                                                                                                                                 |
| PUA            | Signatures which match PUA and Grayware samples                                                                                                          |
| Ransomware     | Signatures which detect ransomware families                                                                                                            |
| Stealer        | Signatures which match for infostealers                                                                                                                  |
| Helpers        | Signatures intended to match on atomic functionality (i.e. settings particular Registry key values)                                                                                                    |
| Shells         | Signatures for samples which serve the sole purpose of spawning remote shell sessions                                                                                                 |

## Required Components

### Meta fields
The following meta fields are **required** and will be chcked by CI (GitHub Actions)

| Field       | Purpose                                                                               | CI Enforcement                                                                                |
| ----------- | ------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| id          | A stable, globally unique identifier used to track a specific detection consistently. | UUIDv4 format (lowercase), must be unique to each rule                                        |
| date        | Last modified timestamp, rather than when the rule was created                        | ``DD-MM-YYYY`` format, valid calendar date (present or past only).                            |
| author      | The rule's creator and maintainer                                                     | Single UTF string comprising of the maintainer's GitHub handle                             |
| description | The intended rule behaviour; what it matches                                          | UTF string, no raw control characters                                                         |
| reference   | Any supporting material related to the rule                                           | Expects ``https?://.*``<br>Multiple references are acceptable if defined as ``reference*``    |
| hash        | N number of hashes which the rule is intended to match for                       | SHA256 is the only acceptable digest<br>Multiple hashes can be provided in the form ``hash*`` |
