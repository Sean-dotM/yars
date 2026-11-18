rule win_go_compiled
{
    meta:
        id = "C9ED8DE8-7BB6-4184-BF00-8ECFF72DF54A"
        date = "17/11/2026"
        author = "Sean Moll"
        description = "Matches compiled Go binaries for Windows"
        reference = "https://unit42.paloaltonetworks.com/the-gopher-in-the-room-analysis-of-golang-malware-in-the-wild/"
        hash = "4b12680e735a62ef4ddc5e3df98874795f3b6d6fe2daca513de872aa5e56c4e7"

    strings:
        $go1 = "Go buildinf:"
        $go2 = "go.buildid"
        $go3 = "runtime.main"
        $go4 = "go1.2"

    condition:
        (unit16(0) == 0x5a4d) and (2 of $go*)
}