#################
# Sol Benchmark #
#################

import strutils
import times
import os

import ../sol

############
# Settings #
############

const solRuns = 10_000_000 # How many runs to average.
const solPrecision = 20 # Benchmark float accuracy.

#############
# Templates #
#############

template bench(name: string, code: untyped) =
    var start: float64 = 0
    var average: float64 = 0
    var i = 0
    while i < solRuns:
        start = epochTime()
        code
        average += (epochTime() - start)
        i += 1
    echo ""
    echo "[sol] Benchmark for: " & name
    average = 1 / (average / solRuns)
    var output = average.formatFloat(format = ffDecimal, precision = solPrecision)
    echo "-> Runs Per Second: " & output

###################
# Main Benchmarks #
###################
echo "[sol] Starting benchmark @" & $solRuns & " runs per test."

echo "[sol] Initializing test values..."
var b: bool = false

var fa: Float = 16.0
var fb: Float = 8.0
var fc: Float = 0.0

var v2a: Vec2 = vec2_initf(16)
var v2b: Vec2 = vec2_initf(8)
var v2c: Vec2 = vec2_zero()
var rad: Float = cv_deg_rad(90)

var v3a: Vec3 = vec3_initf(16)
var v3b: Vec3 = vec3_initf(8)
var v3c: Vec3 = vec3_zero()
var quat: Vec4 = cv_axis_quat(vec4_init(0, 1, 0, cv_deg_rad(90)))

var v4a: Vec4 = vec4_initf(16)
var v4b: Vec4 = vec4_initf(8)
var v4c: Vec4 = vec4_zero()

var m2a: Mat2 = mat2_initf(16)
var m2b: Mat2 = mat2_initf(8)
var m2c: Mat2 = mat2_zero()

var m3a: Mat3 = mat3_initf(16)
var m3b: Mat3 = mat3_initf(8)
var m3c: Mat3 = mat3_zero()

var m4a: Mat4 = mat4_initf(16)
var m4b: Mat4 = mat4_initf(8)
var m4c: Mat4 = mat4_zero()

echo ""
echo "[sol] Float Benchmarks"

bench "+":
    fc = fa + fb

bench "-":
    fc = fa - fb

bench "*":
    fc = fa * fb

bench "/":
    fc = fa / fb

bench "flt_pow":
    fc = flt_pow(fa, fb)

bench "flt_sqrt":
    fc = flt_sqrt(fa)

bench "flt_sin":
    fc = flt_sin(fa)

bench "flt_cos":
    fc = flt_cos(fa)

bench "flt_acos":
    fc = flt_acos(fa)

echo ""
echo "[sol] Vec2 Benchmarks"

bench "vec2_norm":
    v2c = vec2_norm(v2c)

bench "vec2_mag":
    fc = vec2_mag(v2c)

bench "vec2_eq":
    b = vec2_eq(v2a, v2b, 0.1)

bench "vec2_rot":
    v2c = vec2_rot(v2c, rad)

bench "vec2_cross":
    fc = vec2_cross(v2a, v2b)

bench "vec2_dot":
    fc = vec2_dot(v2a, v2b)

bench "vec2_sum":
    fc = vec2_sum(v2c)

bench "vec2_add":
    v2c = v2a + v2b

bench "vec2_sub":
    v2c = v2a - v2b

bench "vec2_mul":
    v2c = v2a * v2b

bench "vec2_div":
    v2c = v2a / v2b

bench "vec2_avg":
    v2c = vec2_avg(v2a, v2b)

echo ""
echo "[sol] Vec3 Benchmarks"

bench "vec3_norm":
    v3c = vec3_norm(v3c)

bench "vec3_mag":
    fc = vec3_mag(v3c)

bench "vec3_eq":
    b = vec3_eq(v3a, v3b, 0.1)

bench "vec3_rot":
    v3c = vec3_rot(v3a, quat)

bench "vec3_cross":
    v3c = vec3_cross(v3a, v3b)

bench "vec3_dot":
    fc = vec3_dot(v3a, v3b)

bench "vec3_sum":
    fc = vec3_sum(v3c)

bench "vec3_add":
    v3c = v3a + v3b

bench "vec3_sub":
    v3c = v3a - v3b

bench "vec3_mul":
    v3c = v3a * v3b

bench "vec3_div":
    v3c = v3a / v3b

bench "vec3_avg":
    v3c = vec3_avg(v3a, v3b)

echo ""
echo "[sol] Vec4 Benchmarks"

bench "vec4_norm":
    v4c = vec4_norm(v4c)

bench "vec4_mag":
    fc = vec4_mag(v4c)

bench "vec4_eq":
    b = vec4_eq(v4a, v4b, 0.1)

bench "vec4_sum":
    fc = vec4_sum(v4c)

bench "vec4_add":
    v4c = v4a + v4b

bench "vec4_sub":
    v4c = v4a - v4b

bench "vec4_mul":
    v4c = v4a * v4b

bench "vec4_div":
    v4c = v4a / v4b

bench "vec4_avg":
    v4c = vec4_avg(v4a, v4b)

echo ""
echo "[sol] Mat2 Benchmarks"

bench "mat2_add":
    m2c = m2a + m2b

bench "mat2_sub":
    m2c = m2a - m2b

bench "mat2_mul":
    m2c = m2a * m2b

bench "mat2_div":
    m2c = m2a / m2b

bench "mat2_avg":
    m2c = mat2_avg(m2a, m2b)

echo ""
echo "[sol] Mat3 Benchmarks"

bench "mat3_add":
    m3c = m3a + m3b

bench "mat3_sub":
    m3c= m3a - m3b

bench "mat3_mul":
    m3c = m3a * m3b

bench "mat3_div":
    m3c = m3a / m3b

bench "mat3_avg":
    m3c = mat3_avg(m3a, m3b)

echo ""
echo "[sol] Mat4 Benchmarks"

bench "mat4_add":
    m4c = m4a + m4b

bench "mat4_sub":
    m4c = m4a - m4b

bench "mat4_mul":
    m4c = m4a * m4b

bench "mat4_div":
    m4c = m4a / m4b

bench "mat4_avg":
    m4c = mat4_avg(m4a, m4b)