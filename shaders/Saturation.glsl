precision mediump float;
 varying vec2 vTextureCoord;
 
 uniform lowp sampler2D inputSTexture;
 uniform lowp float inputSaturation;
 
 const mediump vec3 luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);
 
 void main()
 {
    lowp vec4 textureColor = texture2D(inputSTexture, vTextureCoord);
    lowp float luminance = dot(textureColor.rgb, luminanceWeighting);
    lowp vec3 greyScaleColor = vec3(luminance);
    
    gl_FragColor = vec4(mix(greyScaleColor, textureColor.rgb, inputSaturation), textureColor.w);
     
 }