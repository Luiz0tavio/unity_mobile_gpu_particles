﻿Shader "Unlit/ParticleCircle"
{
     SubShader {
        
         Pass {
             CGPROGRAM
 
             #pragma target 2.0
             #pragma vertex vert
             #pragma fragment frag
 
             struct fragmentInput {
                 float4 pos    : SV_POSITION;
                 float2 uv     : TEXCOORD0;
                 float3 normal : NORMAL;
             };
             
             struct vertexInput {
                float4 pos : POSITION;
                float2 id  : TEXCOORD2;
                float2 uv  : TEXCOORD0;
             };
 
             fragmentInput vert (vertexInput v)
             {
                 fragmentInput o;
 
                 o.pos = UnityObjectToClipPos(v.pos);
                 o.uv = v.uv.xy - fixed2(0.5, 0.5);
                 
                 o.pos.xy += v.id.x;
                 
                 return o;
             }
 
             fixed4 frag(fragmentInput i) : SV_Target 
             {
                 float distance = sqrt(pow(i.uv.x, 2) + pow(i.uv.y, 2));
                 
                 if (distance <= 0.5f) {
                     return fixed4(0, 1, 0, 1);
                 }
                 
                 discard;
                 return fixed4(0, 0, 0, 0); // for compile reasons.
             }
             
             ENDCG
         }
    }
}