using System;
using System.Collections.Generic;

/**
 * Suite, Spec, and Block base class
 */
public class Jasmine.Executable : Object
{
    public bool abort;
    public virtual void Execute(OnCompleteDelegate onComplete){}
    protected Queue queue;

    public virtual NestedResults Results(){
        return new NestedResults();
    }
}

/**
 * Testing Results base class
 */
public class Jasmine.Resultable : Object
{
    protected string type;
    /**
    * The total count of results
    */
    protected int totalCount;
    /**
    * Number of passed results
    */
    protected int passedCount;
    /**
    * Number of failed results
    */
    protected int failedCount;
    /**
    * Was this suite/spec skipped?
    */
    protected bool skipped;

    protected ArrayList<Resultable> items;

    /**
     * Roll up the result counts.
     *
     * @param result
     */
    public void RollupCounts(Resultable result)
    {
        totalCount += result.totalCount;
        passedCount += result.passedCount;
        failedCount += result.failedCount;
    }

    /**
     * @returns {Boolean} True if <b>everything</b> below passed
     */
    public bool Passed()
    {
        return passedCount == totalCount;
    }
    public bool Skipped {
        get { return skipped; }
        set { skipped = value; }
    }

}


public class Jasmine.Reporter : Object
{
    public virtual void ReportRunnerStarting(Runner runner){}
    public virtual void ReportRunnerResults(Runner runner){}
    public virtual void ReportSuiteResults(Suite suite){}
    public virtual void ReportSpecStarting(Spec spec){}
    public virtual void ReportSpecResults(Spec spec){}
    public virtual void Log(string str){}
}

