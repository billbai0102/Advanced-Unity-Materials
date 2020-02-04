using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TransformGrid : MonoBehaviour
{
    public Transform prefab;
    public int gridRes = 10;
    Transform[] grid;

    private void Awake()
    {
        grid = new Transform[gridRes * gridRes * gridRes];

        for (int i = 0, z = 0; z < gridRes; z++)
        {
            for (int y = 0; y < gridRes; y++)
            {
                for (int x = 0; x < gridRes; x++)
                {
                    grid[i] = CreateGridPoint(x, y, z);
                }
            }
        }
    }

    Transform CreateGridPoint(int x, int y, int z)
    {
        Transform point = Instantiate<Transform>(prefab);

        point.localPosition = GetCoordinates(x, y, z);
        point.GetComponent<MeshRenderer>().material.color = new Color(
            (float) x / gridRes,
            (float) y / gridRes,
            (float) z / gridRes
            );
        return point;
    }

    Vector3 GetCoordinates(int x, int y, int z)
    {
        return new Vector3(
            x - (gridRes - 1) * 0.5f,
            y - (gridRes - 1) * 0.5f,
            z - (gridRes - 1) * 0.5f
            );
    }
}
