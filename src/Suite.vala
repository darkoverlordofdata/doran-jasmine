using System.Collections.Generic;
/**
 * Internal representation of a Jasmine suite.
 *
 * @constructor
 * @param {jasmine.Env} env
 * @param {String} description
 * @param {Function} specDefinitions
 * @param {jasmine.Suite} parentSuite
 */
public class Jasmine.Suite : Executable
{
    private int id;
    private string description;
    private Suite? parentSuite;
    private Env env;
    private bool finished;

    private ArrayList<CallbackWrapper> before;
    private ArrayList<CallbackWrapper> after;
    private ArrayList<Object> children;
    private ArrayList<Suite> suites;
    private ArrayList<Spec> specs;

    public Suite(Env env, string description, Callback specDefinitions, Suite? parentSuite = null)
    {
        this.id = env.NextSuiteId();
        this.description = description;
        this.parentSuite = parentSuite;
        this.env = env;
        this.queue = new Queue(env);
        this.before = new ArrayList<CallbackWrapper>();
        this.after = new ArrayList<CallbackWrapper>();
        this.children = new ArrayList<Object>();
        this.suites = new ArrayList<Suite>();
        this.specs = new ArrayList<Spec>();
        this.finished = false;
    }

    public Suite? ParentSuite()
    {
        return parentSuite;
    }

    public ArrayList<Spec> Specs()
    {
        return specs;
    }

    public string GetFullName()
    {
        var fullName = description;
        for (var parentSuite = this.parentSuite; parentSuite != null; parentSuite = parentSuite.parentSuite) {
            fullName = parentSuite.description + " " + fullName;
        }
        return fullName;
    }

    public void Finish(OnCompleteDelegate onComplete)
    {
        env.Reporter.ReportSuiteResults(this);
        finished = true;
        onComplete();

    }

    public void BeforeEach(Callback beforeEachFunction)
    {
        before.Insert(0, Wrapper(beforeEachFunction));
    }

    public void AfterEach(Callback afterEachFunction)
    {
        after.Insert(0, Wrapper(afterEachFunction));
    }

    public NestedResults Results()
    {
        return queue.Results();
    }



    public void AddSuite(Suite suite)
    {
        children.Add(suite);
        suites.Add(suite);
        env.CurrentRunner().AddSuite(suite);
        queue.Add(suite);
    }

    public void AddSpec(Spec spec)
    {
        children.Add(spec);
        specs.Add(spec);
        queue.Add(spec);
    }

    public override void Execute(OnCompleteDelegate onComplete)
    {
        var me = this;
        queue.Start(() => me.Finish(onComplete));
    }
}

