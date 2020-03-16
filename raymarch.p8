pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- config

cam_org = {x=0.0, y=0.0, z=-2.0}
offset = 1.5
frames = {}
frame_count = 8.
frame_index = 1.
slow = 2
tick = 0
-->8
-- vector

function v_sub(a, b)
    return {
        x=a.x-b.x,
        y=a.y-b.y,
        z=a.z-b.z
    }
end

function v_add(a, b)
    return {
        x=a.x+b.x,
        y=a.y+b.y,
        z=a.z+b.z
    }
end

function v_dis(a,b)
    return sqrt(
        (b.x - a.x)*(b.x - a.x)+
        (b.y - a.y)*(b.y - a.y)+
        (b.z - a.z)*(b.z - a.z)
    )
end

function v_mul(a,k)
    return {
        x=a.x*k,
        y=a.y*k,
        z=a.z*k
    }
end

function v_len(a)
    origin = {x=0, y=0, z=0}
    return v_dis(a, origin)
end

function v_abs(a)
    return {
        x=abs(a.x),
        y=abs(a.y),
        z=abs(a.z)
    }
end

function v_rotx(a, r)
    return v_add(
       {x=a.x, y=a.y*cos(r), z=a.z*cos(r)},
       {x=0.0, y=a.z*sin(r), z=-a.y*sin(r)}
    )
end

function v_roty(a, r)
    return v_add(
       {x=a.x*cos(r), y=a.y, z=a.z*cos(r)},
       {x=a.z*sin(r), y=0.0, z=-a.x*sin(r)}
    )
end
-->8
-- raymarch

function draw_pixel(x,y,c)
    line(x,y,x,y,c)
end

function scene(ray, n)
    ray = v_roty(ray, n/frame_count/4.)
    size = 0.5
    ray = v_abs(ray)
    d = (ray.x+ray.y+ray.z-size)*0.57735027
    return d
    -- sphere
    --[[
    radius = 0.6
    sphere = v_len(ray) - radius
    return sphere
    --]]
end

function trc(ray_org, ray_dir, n)
    ray = ray_org
    dist = 0.0
    tot_dist = 0.0
    max_dist = 1.0
    for i=1,8 do
        dist = scene(ray, n)
        ray = v_add(ray, v_mul(ray_dir, dist))
        if dist <= 0.01 then
            return tot_dist/max_dist + 8
        end
        tot_dist = tot_dist + dist
    end
    return 1/15
end

function get_pixel(x,y,off,n)
    ray_org = {x=x, y=y, z=cam_org.z+off}
    ray_dir = v_sub(ray_org, cam_org)
    c = trc(ray_org, ray_dir, n)
    return flr(c * 15)
end

function fill_frame(n)
    frame = {}
    for x=0,127 do
        row = {}
        x_n = (x/127) * 2 - 1
        for y=0,127 do
            y_n = (y/127) * 2 - 1
            row[y] = get_pixel(x_n,y_n,offset, n)
        end
        frame[x] = row
    end
    frames[n] = frame
    --offset = offset + 0.05
end

function draw_frame(n)
    cls(0)
    for x=0,127 do
        for y=0,127 do
            draw_pixel(
                x,
                y,
                frames[n][x][y]
            )
        end
    end
end

-->8
-- main

function _init()
    for n=1,frame_count do
      cls(0)
      print("loading " ..n.. "/" ..frame_count)
      fill_frame(n)
    end
end

function _draw()
    if tick % slow == 0 then
      draw_frame(frame_index)
      frame_index = frame_index + 1
      if frame_index > frame_count then
        frame_index = 1
      end
    end
    tick = tick + 1
end

-->8
-- test

--[[
_init()

for i=1,frame_count do
    f = frames[i]
    print("# frame",i)
    for k_i,v_i in pairs(f) do
        for k_j,v_j in pairs(v_i) do
            print(k_i,"-",k_j,":", v_j)
        end
    end
end

_draw()
--]]
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
