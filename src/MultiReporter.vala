using System;
using System.Collections.Generic;


public class Jasmine.MultiReporter : Reporter
{
    private ArrayList<Reporter> subReporters;

    public MultiReporter()
    {
        this.subReporters = new ArrayList<Reporter>();
    }
    public void AddReporter(Reporter reporter)
    {
        subReporters.Add(reporter);
    }

    public override void ReportRunnerStarting(Runner runner)
    {
        foreach (var reporter in subReporters) 
            reporter.ReportRunnerStarting(runner);
    }
    public override void ReportRunnerResults(Runner runner)
    {
        foreach (var reporter in subReporters) 
            reporter.ReportRunnerResults(runner);
    }
    public override void ReportSuiteResults(Suite suite)
    {
        foreach (var reporter in subReporters) 
            reporter.ReportSuiteResults(suite);
    }
    public override void ReportSpecStarting(Spec spec)
    {
        foreach (var reporter in subReporters) 
            reporter.ReportSpecStarting(spec);
    }
    public override void ReportSpecResults(Spec spec)
    {
        foreach (var reporter in subReporters) 
            reporter.ReportSpecResults(spec);
    }
    public override void Log(string str)
    {
        foreach (var reporter in subReporters) 
            reporter.Log(str);
    }

}

