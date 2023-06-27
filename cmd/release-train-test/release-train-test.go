package main

import (
	"fmt"
	"runtime/debug"

	"github.com/alecthomas/kong"
)

var version = ""

func getVersion() string {
	if version != "" {
		return version
	}
	info, ok := debug.ReadBuildInfo()
	if ok {
		return info.Main.Version
	}
	return "unknown"
}

const description = `` // add description here

type cmdRoot struct {
	Version kong.VersionFlag `kong:"help=${VersionHelp}"`
}

var kongVars = kong.Vars{
	"version":     getVersion(),
	"VersionHelp": `Output the release-train-test version and exit.`,
}

func main() {
	var cli cmdRoot
	k := kong.Parse(&cli,
		kongVars,
		kong.Description(description),
	)

	fmt.Fprintln(k.Stdout, "hello, world")
}
