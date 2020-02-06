Shader "Custom/BasicShader"
{

    Properties{
    
    }

    SubShader{
        Pass{
            CGPROGRAM
            
            // Prevents mul(UNITY_MATRIX_MVP, *) being replaced with UnityObjectToClipPos(*)
            #define UNITY_SHADER_NO_UPGRADE 1
            
            #pragma vertex VertexProgram
            #pragma fragment FragmentProgram
            
            #include "UnityCG.cginc"
            
            float4 VertexProgram(float4 position : POSITION) : SV_POSITION{
                return mul(UNITY_MATRIX_MVP, position);
            }
            
            float4 FragmentProgram(float4 position : SV_POSITION) : SV_TARGET{
                return float4(1, 1, 0, 1);
            }
            
            ENDCG
        }
    }
}
