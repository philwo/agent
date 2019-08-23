package agent

import "runtime"

// You can overridden buildVersion at compile time by using:
//
//  go run -ldflags "-X github.com/buildkite/agent/agent.buildVersion abc" *.go --version
//
// On CI, the binaries are always build with the buildVersion variable set.

var baseVersion string = "3.13.2"
var buildVersion string = "bazel1"

func Version() string {
	return baseVersion
}

func BuildVersion() string {
	if buildVersion != "" {
		return buildVersion
	} else {
		return "x"
	}
}

func UserAgent() string {
	return "buildkite-agent/" + Version() + "." + BuildVersion() + " (" + runtime.GOOS + "; " + runtime.GOARCH + ")"
}
