/**
 * QADCA class originally created by Gaiaonline.
 * @author Gaiaonline
 */
class QADCA
{
	static var awesome = null;
    static var bol = new Array();
    static var bolmax: Number = 100;
    static var bolc: Number = 0;
	
	public function QADCA() 
	{
	}
	
	static function e0(id, s)
    {
        var __reg1 = undefined;
        __reg1 = e1(id, s);
        __reg1 = e2(id, __reg1);
        __reg1 = e3(id, __reg1);
        return __reg1;
    }

    static function d0(id, s)
    {
        var __reg1 = new Object();
        if (iih(s)) 
        {
            __reg1.b = false;
            return __reg1;
        }
        s = d3(id, s);
        s = d2(id, s);
        __reg1 = d1(id, s);
        return __reg1;
    }

    static function e1(id, s)
    {
        var __reg1 = e1iMod(id);
        var __reg2 = __reg1 + s + __reg1;
        return __reg2;
    }

    static function e1iMod(id)
    {
        var __reg1 = id % 80;
        __reg1 = __reg1 + 19;
        return __reg1;
    }

    static function d1(id, s)
    {
        var __reg1 = s.split("");
        var __reg5 = __reg1.pop();
        __reg1.pop();
        __reg1.reverse();
        var __reg6 = __reg1.pop();
        __reg1.pop();
        var __reg4 = __reg6 + "" + __reg5;
        var __reg8 = e1iMod(id);
        var __reg3 = false;
        if (__reg4 == __reg8) 
        {
            __reg3 = true;
        }
        __reg1.reverse();
        var __reg7 = __reg1.join("");
        var __reg2 = new Object();
        __reg2.b = __reg3;
        __reg2.s = __reg7;
        return __reg2;
    }

    static function e2(id, s)
    {
        var __reg4 = s.split("");
        var __reg3 = new Array();
        var __reg5 = id % 3;
        var __reg1 = 0;
        while (__reg1 < s.length) 
        {
            if (__reg1 % 3 == __reg5) 
            {
                var __reg2 = chr(Math.round(Math.random() * 200) + 33);
                __reg3.push(__reg2);
            }
            __reg3.push(__reg4[__reg1]);
            ++__reg1;
        }
        var __reg7 = __reg3.join("");
        return __reg7;
    }

    static function d2(id, s)
    {
        var __reg2 = s.split("");
        var __reg5 = new Array();
        var __reg6 = id % 3;
        var __reg3 = 0;
        var __reg8 = 0;
        var __reg1 = 0;
        while (__reg1 < s.length) 
        {
            if (__reg1 % 3 == __reg6) 
            {
                __reg2[__reg1 + __reg3] = awesome;
                ++__reg3;
            }
            ++__reg1;
        }
        __reg1 = 0;
        while (__reg1 < s.length) 
        {
            if (__reg2[__reg1] != awesome) 
            {
                __reg5.push(__reg2[__reg1]);
            }
            ++__reg1;
        }
        var __reg7 = __reg5.join("");
        return __reg7;
    }

    static function e3(id, s)
    {
        var __reg3 = s.split("");
        var __reg1 = 0;
        while (__reg1 < __reg3.length) 
        {
            var __reg2 = ord(__reg3[__reg1]);
            var __reg4 = id % 10 + 10;
            __reg2 = __reg2 - __reg4;
            __reg3[__reg1] = chr(__reg2);
            ++__reg1;
        }
        var __reg6 = __reg3.join("");
        return __reg6;
    }

    static function d3(id, s)
    {
        var __reg3 = s.split("");
        var __reg1 = 0;
        while (__reg1 < __reg3.length) 
        {
            var __reg2 = ord(__reg3[__reg1]);
            var __reg4 = id % 10 + 10;
            __reg2 = __reg2 + __reg4;
            __reg3[__reg1] = chr(__reg2);
            ++__reg1;
        }
        var __reg6 = __reg3.join("");
        return __reg6;
    }

    static function iih(s)
    {
        var __reg2 = false;
        var __reg1 = 0;
        while (__reg1 < bolmax) 
        {
            if (bol[__reg1] == s) 
            {
                __reg2 = true;
            }
            ++__reg1;
        }
        bol[bolc++ % bolmax] = s;
        return __reg2;
    }
}