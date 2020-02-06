﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PosTransformation : Transformation
{
    public Vector3 position;

    public override Vector3 Apply(Vector3 point)
    {
        return point + position;
    }
}
