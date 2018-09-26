using System;
using System.Collections.Generic;
/**
 * Blocks are functions with executable code that make up a spec.
 *
 * @constructor
 * @param {jasmine.Env} env
 * @param {Function} func
 * @param {jasmine.Spec} spec
 */
public class Jasmine.Block : Executable
{
    private Env env;
    private Callback func;
    private Spec spec;

    public Spec GetSpec()
    {
        return spec;
    }
    public Block(Env env, Callback func, Spec spec)
    {
        this.env = env;
        this.func = func;
        this.spec = spec;
    }
    public override void Execute(OnCompleteDelegate onComplete)
    {
        if (!Jasmine.CATCH_EXCEPTIONS) {
            func();
        } else {
            try {
                func();
            } catch (Exception e) {
                spec.Fail(e);
            }
        }
        onComplete();
    }

}
