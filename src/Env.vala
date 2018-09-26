using System;
using System.Collections.Generic;
/**
 * Environment for Jasmine
 *
 * @constructor

http://jsfiddle.net/jasonmcaffee/yhZBv/

describe("running jasmine in jsfiddle", function(){
    it("should run tests", function(){
        expect(true).toEqual(true);
    });
});

(function() {
  var env = jasmine.getEnv();
  env.addReporter(new jasmine.HtmlReporter());
  env.execute();
}());


 */    
public class Jasmine.Env : Object
{
    internal Spec currentSpec;
    private Suite currentSuite;
    private Runner currentRunner;
    private MultiReporter reporter;
    private int lastUpdate = 0;
    private int nextSpecId = 0;
    private int nextSuiteId = 0;

    private ArrayList<string> names;

    public Spec CurrentSpec {
        get { return currentSpec; }
        set { currentSpec = value; }
    }

    public MultiReporter Reporter { get { return reporter; } }
    public Env()
    {
        currentRunner = new Runner(this);
        reporter = new MultiReporter();
        names = new ArrayList<string>();
    }

    public Version GetVersion() {
        return version;
    }

    public int NextSpecId() {
        return nextSpecId++;
    }

    public int NextSuiteId() {
        return nextSuiteId++;
    }

    public bool SpecFilter()
    {
        return true;
    }
    /**
     * Register a reporter to receive status updates from Jasmine.
     * @param {jasmine.Reporter} reporter An object which will receive status updates.
     */
    public void AddReporter(Reporter reporter) 
    {
        Reporter.AddReporter(reporter);
    }

    public void Execute()
    {
        currentRunner.Execute();
    }

    public Suite Describe(string description, Callback specDefinitions)
    {
        var suite = new Suite(this, description, specDefinitions, currentSuite);

        var parentSuite = currentSuite;
        if (parentSuite != null) {
            parentSuite.AddSuite(suite);
        }
        else {
            currentRunner.AddSuite(suite);
        }
        currentSuite = suite;
        Error declarationError = null;
        try {
            specDefinitions();
        } catch (Error e) { 
            declarationError = e;
        }

        if (declarationError != null) {
            It("encountered a declaration exception", () => {
                throw declarationError;
            });
        }
        currentSuite = parentSuite;
        return suite;
    }

    public void BeforeEach(Callback beforeEachFunction) 
    {
        if (currentSuite != null) {
            currentSuite.BeforeEach(beforeEachFunction);
        } else {
            currentRunner.BeforeEach(beforeEachFunction);
        }
    }

    public Runner CurrentRunner() {
        return currentRunner;
    }

    public void AfterEach(Callback afterEachFunction) 
    {
        if (currentSuite != null) {
            currentSuite.AfterEach(afterEachFunction);
        } else {
            currentRunner.AfterEach(afterEachFunction);
        }
    }

    public Suite XDescribe(string description, Callback specDefinitions)
    {
        return (Suite)new Executable();
    }

    public Spec It(string description, Callback func)
    {
        var spec = new Spec(this, currentSuite, description);
        
        currentSuite.AddSpec(spec);
        currentSpec = spec;

        spec.Runs(func);
        return spec;
    }

    public Spec XIt(string description, Callback func)
    {
        return (Spec)new Executable();
    }
}


