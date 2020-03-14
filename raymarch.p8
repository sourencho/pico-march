pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
cam_org = {x=0.0, y=0.0, z=-2.0}
tick = 0
offset = 0.9

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

function pix(x,y,c)
  line(x,y,x,y,c)
end

function scene(ray)
  radius = 0.6
  sphere = v_len(ray) - radius
  return sphere
end

function trc(ray_org, ray_dir)
  ray = ray_org
  dist = 0.0
  tot_dist = 0.0
  max_dist = 1.0
  for i=1,4 do
    dist = scene(ray)
    ray = v_add(
      ray,
      v_mul(ray_dir, dist)
    )
    if dist <= 0.01 then
      return tot_dist/max_dist
    end
    tot_dist = tot_dist + dist
  end
  return 1/16
end

function draw_pix(x,y)
  cls(7)
  ray_org = {x=x, y=y, z=cam_org.z+offset}
  ray_dir = v_sub(ray_org, cam_org)
  c = trc(ray_org, ray_dir)
  pix(
    (x+1)/2*127,
    (y+1)/2*127,
    flr(c * 16)
  )
end

function _init()
  cls(7)
  print("init")
end

function _update()
  for x=0,127 do
    x = (x / 127) * 2 - 1
    for y=0,127 do
      y = (y / 127) * 2 - 1
      draw_pix(x,y)
    end
  end
  offset = offset + 0.03
  if offset > 1.1 then
    offset = 0.9
  end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
