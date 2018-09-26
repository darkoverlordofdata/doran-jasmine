using System;
using System.Collections.Generic;

/**
 * @constructor
 * @param {jasmine.Env} env
 * @param actual
 * @param {jasmine.Spec} spec
 */
public class Jasmine.Matchers<G> : Object
{
    private Env env;
    private G? actual;
    private Spec spec;
    private bool isNot;
    private bool reportWasCalled;
    public Matchers<G> Not;

    public Matchers(Env env, G? actual, Spec spec, bool isNot = false)
    {
        this.env = env;
        this.actual = actual;
        this.spec = spec;
        this.isNot = isNot;
        this.reportWasCalled = false;
    }

    /**
     * toBe: compares the actual to the expected using ===
     * @param expected
     */
    public bool ToBe<G>(G? expected)
    {
        // return IsEqual<G>(actual, expected);
        var b = IsEqual<G>(actual, expected);
        if (b) print("pass\n"); else print("fail\n");
        return b;
    }

    /**
     * toNotBe: compares the actual to the expected using !==
     * @param expected
     * @deprecated as of 1.0. Use not.toBe() instead.
     */
    public bool NotToBe(G? expected)
    {
        // return !IsEqual<G>(actual, expected);
        var b = !IsEqual<G>(actual, expected);
        if (b) print("pass\n"); else print("fail\n");
        return b;
    }

    static bool IsEqual<G>(G? a, G? b)
    {   
        switch (typeof(G))
        {
            // case Type.SHORT: return (short)a == (short)b;
            case Type.BOOLEAN: return (bool)a == (bool)b;
            case Type.CHAR: return (char)a == (char)b;
            case Type.DOUBLE: return (double?)a == (double?)b;
            case Type.ENUM: return (int)a == (int)b;
            case Type.FLOAT: return (float?)a == (float?)b;
            case Type.INT: return (int)a == (int)b;
            case Type.INT64: return (int64)a == (int64)b;
            // case Type.INTERFACE: return ((Object)a).Equals((Object)b);
            case Type.LONG: return (long)a == (long)b;
            case Type.OBJECT: return (Object)a == (Object)b;
            // case Type.OBJECT: return ((Object)a).Equals((Object)b);
            case Type.POINTER: return (void*)a == (void*)b;
            case Type.STRING: return (string)a == (string)b;
            case Type.UCHAR: return (uchar)a == (uchar)b;
            case Type.UINT: return (uint)a == (uint)b;
            case Type.UINT64: return (uint64)a == (uint64)b;
            case Type.ULONG: return (ulong)a == (ulong)b;
            // case Type.VARIANT: return (float)a == (float)b;
            
            default: assert_not_reached();
        }
    }

}

