Shader "Custom/TexMap"
{

    Properties{
        _MainTex ("TexMap", 2D) = "white"{} // Some older compilers expect empty brackets
        [NoScaleOffset] _Texture1 ("Texture 1", 2D) = "white" {}
        [NoScaleOffset] _Texture2 ("Texture 2", 2D) = "white" {}
        [NoScaleOffset] _Texture3 ("Texture 3", 2D) = "white" {}
        [NoScaleOffset] _Texture4 ("Texture 4", 2D) = "white" {}
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
            sampler2D _MainTex;
            float4 _MainTex_ST; // Scale & Transition
            sampler2D _Texture1, _Texture2, _Texture3, _Texture4;
            
            struct Interpolators{
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
                float2 uvTexMap : TEXCOORD1;
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
                i.uvTexMap = v.uv;
                return i;
            }
            
            float4 FragmentProgram(Interpolators i) : SV_TARGET{
                float4 texMap = tex2D(_MainTex, i.uvTexMap);
                return tex2D(_Texture1, i.uv) * texMap.r + 
                       tex2D(_Texture2, i.uv) * texMap.g + 
                       tex2D(_Texture3, i.uv) * texMap.b +
                       tex2D(_Texture4, i.uv) * (1 - texMap.r - texMap.g - texMap.b);
            }
            
            ENDCG
        }
    }
}
