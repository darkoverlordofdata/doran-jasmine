using System;
using System.Collections.Generic;

/**
 * Runner
 *
 * @constructor
 * @param {jasmine.Env} env
 */
public class Jasmine.Runner : Object
{
    private Env env;
    private Queue queue;
    private ArrayList<CallbackWrapper> before;
    private ArrayList<CallbackWrapper> after;
    private ArrayList<Suite> suites;

    public Runner(Env env)
    {
        this.env = env;
        this.queue = new Queue(env);
        this.before = new ArrayList<CallbackWrapper>();
        this.after = new ArrayList<CallbackWrapper>();
        this.suites = new ArrayList<Suite>();
    }

    public void Execute()
    {
        var me = this;
        /** collect all the specs into reporter.suites */
        env.Reporter.ReportRunnerStarting(me);
        /** now magically they are in the runner queue: */
        queue.Start(() => { 
            print("All Done!\n");
            me.FinishCallback();
        });
    }

    public void AddSpecs(Queue queue)
    {
        this.queue.Copy(queue);
    }

    public void BeforeEach(Callback beforeEachFunction)
    {
        before.Insert(0, Wrapper(beforeEachFunction));
    }

    public void AfterEach(Callback afterEachFunction)
    {
        after.Insert(0, Wrapper(afterEachFunction));
    }

    public void FinishCallback()
    {
        env.Reporter.ReportRunnerResults(this);
    }

    public void AddBlock(Block block)
    {
        queue.Add(block);
    }

    public void AddSuite(Suite suite)
    {
        suites.Add(suite);
    }

    public ArrayList<Spec> Specs()
    {
        var specs = new ArrayList<Spec>();
        foreach (var suite in suites)
            foreach (var spec in suite.Specs())
                specs.Add(spec);
        return specs;
    }

    public ArrayList<Suite> Suites()
    {
        return suites;
    }

    public ArrayList<Suite> TopLevelSuites()
    {
        var topLevelSuites = new ArrayList<Suite>();
        foreach (var suite in suites) {
            if (null == suite.ParentSuite()) {
                topLevelSuites.Add(suite);
            }
        }
        return topLevelSuites;
    }

    public NestedResults Results()
    {
        return queue.Results();
    }
}

