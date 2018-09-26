using System;
using System.Collections.Generic;
/**
 * Jasmine (https://jasmine.github.io/) inspired BDD Testing
 *
 * API:
 */
namespace Jasmine
{
    public bool VERBOSE = false;
    public bool CATCH_EXCEPTIONS = true;
    public const Version version = { 0, 0, 1, "0.0.1" };

    public struct Version
    {
        public int Major;
        public int Minor;
        public int Build;
        public string Version;
    }


    private Env currentEnv;
    public Env GetEnv()
    {
        currentEnv = currentEnv ?? new Env();
        return currentEnv;
    }
    /**
     * Creates a Jasmine spec that will be added to the current suite.
     *
     * // TODO: pending tests
     *
     * @example
     * it('should be true', () => {
     *   expect(true).toEqual(true);
     * });
     *
     * @param {String} desc description of this specification
     * @param {Function} func defines the preconditions and expectations of the spec
     */
    public Spec It(string desc, Callback func)
    {
        return GetEnv().It(desc, func);
    }
    /**
     * Creates a <em>disabled</em> Jasmine spec.
     *
     * A convenience method that allows existing specs to be disabled temporarily during development.
     *
     * @param {String} desc description of this specification
     * @param {Function} func defines the preconditions and expectations of the spec
     */
    public Spec XIt(string desc, Callback func)
    {
        return GetEnv().XIt(desc, func);
    }

    /**
     * A function that is called before each spec in a suite.
     *
     * Used for spec setup, including validating assumptions.
     *
     * @param {Function} beforeEachFunction
     */
     public void BeforeEach(Callback beforeEachFunction)
     {
         GetEnv().BeforeEach(beforeEachFunction);
     }

    /**
     * A function that is called after each spec in a suite.
     *
     * Used for restoring any state that is hijacked during spec execution.
     *
     * @param {Function} afterEachFunction
     */
    public void AfterEach(Callback afterEachFunction)
    {
        GetEnv().AfterEach(afterEachFunction);
    }


    /**
     * Defines a suite of specifications.
     *
     * Stores the description and all defined specs in the Jasmine environment as one suite of specs. Variables declared
     * are accessible by calls to beforeEach, it, and afterEach. Describe blocks can be nested, allowing for specialization
     * of setup in some tests.
     *
     * @example
     * // TODO: a simple suite
     *
     * // TODO: a simple suite with a nested describe block
     *
     * @param {String} description A string, usually the class under test.
     * @param {Function} specDefinitions function that defines several specs.
     */    
    public Suite Describe(string description, Callback specDefinitions)
    {
        return GetEnv().Describe(description, specDefinitions);    
    }

    /**
     * Disables a suite of specifications.  Used to disable some suites in a file, or files, temporarily during development.
     *
     * @param {String} description A string, usually the class under test.
     * @param {Function} specDefinitions function that defines several specs.
     */
    public Suite XDescribe(string description, Callback specDefinitions)
    {
        return GetEnv().XDescribe(description, specDefinitions);    
    }

    // public Spec Expect<G>(G? actual)
    // {
    //     return GetEnv().CurrentSpec;//.Expect<G>(actual);
    // }

    public Matchers Expect<G>(G? actual)
    {
        return GetEnv().CurrentSpec.Expect<G>(actual);
    }

    public void Execute()
    {
        GetEnv().Execute();
    }
}

