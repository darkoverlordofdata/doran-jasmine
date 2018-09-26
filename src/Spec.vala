using System;
using System.Collections.Generic;

/**
 * Internal representation of a Jasmine specification, or test.
 *
 * @constructor
 * @param {jasmine.Env} env
 * @param {jasmine.Suite} suite
 * @param {String} description
 */
public class Jasmine.Spec : Executable
{
    private int id;
    private Env env;
    private Suite suite;
    private string description;
    private ArrayList<CallbackWrapper> afterCallbacks;
    private NestedResults results;

    public Spec(Env env, Suite suite, string description)
    {
        this.id = env.NextSpecId();
        this.env = env;
        this.suite = suite;
        this.description = description;
        this.queue = new Jasmine.Queue(env);
        this.afterCallbacks = new ArrayList<CallbackWrapper>();
        this.results = new NestedResults();

    }

    public string GetFullName()
    {
        return suite.GetFullName() + " " + description + ".";
    }

    public Queue Queue()
    {
        return queue;
    }

    public NestedResults Results()
    {
        return results;
    }

    /**
     * All parameters are pretty-printed and concatenated together, then written to the spec's output.
     *
     * Be careful not to leave calls to <code>jasmine.log</code> in production code.
     */
    // [PrintfFormat]
    // public void Log(string format, ...)
    // {
    //     results.Log(format, va_list());
    // }


    public Spec Runs(Callback func)
    {
        var block = new Block(env, func, this);
        AddToQueue(block);
        return this;
    }

    public void AddToQueue(Block block)
    {
        if (queue.IsRunning()) {
            queue.InsertNext(block);
        } else {
            queue.Add(block);
        }
    }

    public void AddMatcherResult(Resultable result)
    {
        results.AddResult(result);
    }

    public Matchers Expect<G>(G? actual)
    {
        var positive = new Matchers<G>(this.env, actual, this);
        positive.Not = new Matchers<G>(this.env, actual, this, true);
        return positive;
    }

    public void FinishCallback()
    {
        env.Reporter.ReportSpecResults(this);
    }

    public void Finish(OnCompleteDelegate onComplete)
    {
        // RemoveAllSpies();
        FinishCallback();
        onComplete();
    }

    public void After(Callback doAfter)
    {
        if (queue.IsRunning()) {
            queue.Add(new Block(env, doAfter, this), true);
        } else {
            afterCallbacks.Insert(0, Wrapper(doAfter));
        }
    }

    public override void Execute(OnCompleteDelegate onComplete)
    {
        if (!env.SpecFilter()) {
            results.Skipped = true;
            Finish(onComplete);
            return;
        }
        env.Reporter.ReportSpecStarting(this);
        env.CurrentSpec = this;
        AddBeforesAndAftersToQueue();

        var me = this;
        queue.Start(() => me.Finish(onComplete));
    }

    public void AddBeforesAndAftersToQueue()
    {

    }

    public void Fail(Exception e)
    {
        
    }

}

