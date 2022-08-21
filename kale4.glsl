#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
varying vec2 vUv;

uniform float u_time;

float SEGMENT_TIME = 4.0;

const float PI = 3.1415926535;

float segmentAngle;

vec2 rotate(vec2 st, float a) {
    st = mat2(cos(a),-sin(a),
              sin(a),cos(a))*(st-.5);
    return st+.5;
}

void main(){
    vec2 newUV = vUv;
    vec2 coord = newUV;

    vec2 rot = rotate(coord, PI + (u_time * 0.125));
    coord = rot;

    float radius = length(coord - 0.5);
    // float angle = atan(coord.x, coord.y);
    float angle = atan(coord.y - 0.5, coord.x - 0.5);

    float segmentAngle = ((PI + 40.0) / SEGMENT_TIME);

    angle -= segmentAngle + floor(angle - segmentAngle);

    angle = min(angle, segmentAngle * angle);

    vec2 st = vec2(sin((cos(-angle * u_time), sin(angle + -u_time)) * radius * segmentAngle))  ;

    st = max(min(st, 30.0 * st), -st);

    vec3 color = vec3(0.0, cos(sin(-u_time) / st));

    // float angle = atan(-coord.y + 0.25, coord.x - 0.5) * 0.1;
    float len = length(coord - vec2(0.5, 0.5));

    // color.r += sin(len * 40.0 + angle * 40.0 + u_time);
    // color.g += cos(len * 30.0 + angle * 60.0 - u_time);
    // color.b += sin(len * 50.0 + angle * 50.0 + 2.0);

    color.r += sin(len * 20.0 + angle * 40.0 * -sin((u_time / 15.0)));
    color.g /= cos(len * 30.0 + angle * 60.0 * sin((u_time / 15.0)));
    color.b += sin(len * 50.0 + angle * 50.0 * -sin((u_time / 15.0)));

    // color.r += abs(0.1 + length(coord) - 0.6 * abs(sin(u_time * 0.9 / 12.0)));
    // color.g += abs(0.1 + length(coord) - 0.6 * abs(sin(u_time * 0.6 / 4.0)));
    // color.b += abs(0.1 + length(coord) - 0.6 * abs(sin(u_time * 0.3 / 9.0)));

    gl_FragColor = vec4(color, 1.0);
}