Shader "Unlit/5_1_Simplest"
{
    Properties
    {
        //声明一个Color属性
        _Color("Color Tint", Color) = (1.0,1.0,1.0,1.0)
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            fixed4 _Color;

            struct a2v
            {
                //指示Unity用模型空间的顶点坐标填充vertex变量
                float4 vertex : POSITION;
                //指示Unity用模型空间的法线填充normal变量
                float3 normal : NORMAL;
                //指示Unity用模型的第一套纹理坐标填充texcoord
                float4 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                //SV_POSITION语义告诉Unity,pos包含裁剪空间下顶点位置信息
                float4 pos : SV_POSITION;
                fixed3 color : COLOR0;

            };

            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = v.normal * 0.5 + fixed3(0.5,0.5,0.5);
                return o;
                
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed3 c = i.color;
                c *= _Color.rgb;
                return fixed4(c,1.0);
            }
            ENDCG
        }
    }
}
