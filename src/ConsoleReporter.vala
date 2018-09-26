using System;
using System.Collections.Generic;


public class Jasmine.ConsoleReporter : Reporter
{

    public ConsoleReporter()
    {
    }

    public override void ReportRunnerStarting(Runner runner)
    {
        /** copy blocks from each spec-queue to the runner-queue: */
        var specs = runner.Specs();
        for (var i=0; i<specs.Count; i++)
            runner.AddSpecs(specs[i].Queue());
    }
    public override void ReportRunnerResults(Runner runner)
    {
        print("ConsoleReporter::ReportRunnerResults\n");
    }
    public override void ReportSuiteResults(Suite suite)
    {
        print("ConsoleReporter::ReportSuiteResults\n");
    }
    public override void ReportSpecStarting(Spec spec)
    {
        print("ConsoleReporter::ReportSpecStarting\n");
    }
    public override void ReportSpecResults(Spec spec)
    {
        print("ConsoleReporter::ReportSpecResults\n");
    }
    public override void Log(string str)
    {
        print("ConsoleReporter::Log\n");
    }

}

