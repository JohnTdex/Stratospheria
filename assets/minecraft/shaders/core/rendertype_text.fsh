#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }

    // --- TARGET ONLY CONTAINER TITLES (#404040 Gray) ---
    // Minecraft container text defaults to roughly 0.25 brightness.
    // Chat defaults to white (1.0) or other colors, so they won't be touched.
    if (color.r > 0.247 && color.r < 0.253 && 
        color.g > 0.247 && color.g < 0.253 && 
        color.b > 0.247 && color.b < 0.253) {
        
        color.r = 0.506;  
        color.g = 0.675;   
        color.b = 0.851;   
    }
    // ---------------------------------------------------

    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}