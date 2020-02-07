Shader "Custom/BasicShader"
{

    Properties{
        _Tint ("Tint", Color) = (1, 1, 1, 1)
        _MainTex ("Texture", 2D) = "white"{} // Some older compilers expect empty brackets
    }

    SubShader{
        Pass{
            CGPROGRAM
            
            // Prevents mul(UNITY_MATRIX_MVP, *) being replaced with UnityObjectToClipPos(*)
            #define UNITY_SHADER_NO_UPGRADE 1
            
            #pragma vertex VertexProgram
            #pragma fragment FragmentProgram
            
            #include "UnityCG.cginc"
            
            //Properties
            float4 _Tint;
            sampler2D _MainTex;
            float4 _MainTex_ST; // Scale & Transition
            
            struct Interpolators{
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
                // float3 localPosition : TEXCOORD0;
            };
            struct VertexData{
                float4 position : POSITION;
                float2 uv : TEXCOORD0;
            };
            
            Interpolators VertexProgram(VertexData v){
                Interpolators i;
                // i.localPosition = v.position.xyz;
                i.position = mul(UNITY_MATRIX_MVP, v.position);
                i.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return i;
            }
            
            float4 FragmentProgram(Interpolators i) : SV_TARGET{
                return tex2D(_MainTex, i.uv) * _Tint;
            }
            
            ENDCG
        }
    }
}
