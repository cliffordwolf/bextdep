#!/usr/bin/env python3

def gatecount(core_id):
    gates = 0
    if core_id.endswith("alu"):
        rpt_file = "vscalealu%s.rpt" % core_id[0:2]
    else:
        rpt_file = "syn%s.rpt" % core_id
    with open(rpt_file) as f:
        for line in f:
            if line.startswith("==="):
                modname = line.split()[1]
                continue
            if "$_DFF_P_" in line:
                gates += 4*int(line.split()[-1])
            if "$_NOR_" in line:
                gates += int(line.split()[-1])
            if "$_NAND_" in line:
                gates += int(line.split()[-1])
            if "$_NOT_" in line:
                gates += 0.5*int(line.split()[-1])
    return gates

def gates(core_id, add_grev=False):
    gates_core = gatecount(core_id)
    gates_core_grev = gates_core + (gatecount("%sgo" % core_id[0:2]) if add_grev else 0)
    gates_ref = gatecount("%salu" % core_id[0:2])
    return (gates_core, gates_core / gates_ref, gates_core_grev / gates_ref)

def lutcount(core_id):
    if core_id.endswith("alu"):
        vivlog_file = "vscalealu%s.vivlog" % core_id[0:2]
    elif core_id == "tinyrocket":
        vivlog_file = "tinyrocket-src/vivado.log"
    else:
        vivlog_file = "bextdep%s.vivlog" % core_id
    with open(vivlog_file) as f:
        for line in f:
            if line.startswith("==="):
                modname = line.split()[1]
                continue
            if "CLB LUTs" in line:
                return int(line.split()[4])
    return None

def maxdelay(core_id):
    if core_id.endswith("alu"):
        vivlog_file = "vscalealu%s.vivlog" % core_id[0:2]
    elif core_id == "tinyrocket":
        vivlog_file = "tinyrocket-src/vivado.log"
    else:
        vivlog_file = "bextdep%s.vivlog" % core_id
    with open(vivlog_file) as f:
        for line in f:
            if line.startswith("==="):
                modname = line.split()[1]
                continue
            if "Data Path Delay" in line:
                return float(line.split()[3][0:-2])
    return None

def luts(core_id, add_grev=False):
    if core_id == "tinyrocket":
        luts_core = lutcount(core_id)
        luts_ref = lutcount("32alu")
        ns_delay = maxdelay(core_id)
        return (luts_core, luts_core / luts_ref, 1000 / ns_delay)

    luts_core = lutcount(core_id)
    luts_core_grev = luts_core + (lutcount("%sgo" % core_id[0:2]) if add_grev else 0)
    luts_ref = lutcount("%salu" % core_id[0:2])
    ns_delay = maxdelay(core_id)
    return (luts_core, luts_core / luts_ref, luts_core_grev / luts_ref, 1000 / ns_delay)

print()
print("| Name          |  Gates |    Rel |  Rel+G | Description                               |")
print("|:------------- | ------:| ------:| ------:|:----------------------------------------- |")
print("| `bextdep64g3` |  %5d |  %5.2f |  %5.2f | 3-stage pipeline with GREV                |" % gates("64g3"))
print("| `bextdep64p3` |  %5d |  %5.2f |  %5.2f | 3-stage pipeline                          |" % gates("64p3", True))
print("| `bextdep64g2` |  %5d |  %5.2f |  %5.2f | 2-stage pipeline with GREV                |" % gates("64g2"))
print("| `bextdep64p2` |  %5d |  %5.2f |  %5.2f | 2-stage pipeline                          |" % gates("64p2", True))
print("| `bextdep64g1` |  %5d |  %5.2f |  %5.2f | single-stage with GREV support            |" % gates("64g1"))
print("| `bextdep64p1` |  %5d |  %5.2f |  %5.2f | single-stage implementation               |" % gates("64p1", True))
print("| `bextdep64sh` |  %5d |  %5.2f |  %5.2f | 4-cycles sequential implementation        |" % gates("64sh", True))
print("| `bextdep64sb` |  %5d |  %5.2f |  %5.2f | 8-cycles sequential implementation        |" % gates("64sb", True))
print("| `bextdep64sn` |  %5d |  %5.2f |  %5.2f | 16-cycles sequential implementation       |" % gates("64sn", True))
print("| `bextdep64sx` |  %5d |  %5.2f |  %5.2f | up-to-64-cycles sequential implementation |" % gates("64sx", True))
print("| `bextdep64go` |  %5d |  %5.2f |  %5.2f | single-stage GREV-only core               |" % gates("64go"))
print("| `vscalealu64` |  %5d |  %5.2f |  %5.2f | ALU from V-Scale CPU (for comparison)     |" % gates("64alu", True))
print()
print("| Name          |  Gates |    Rel |  Rel+G | Description                               |")
print("|:------------- | ------:| ------:| ------:|:----------------------------------------- |")
print("| `bextdep32g3` |  %5d |  %5.2f |  %5.2f | 3-stage pipeline with GREV                |" % gates("32g3"))
print("| `bextdep32p3` |  %5d |  %5.2f |  %5.2f | 3-stage pipeline                          |" % gates("32p3", True))
print("| `bextdep32g2` |  %5d |  %5.2f |  %5.2f | 2-stage pipeline with GREV                |" % gates("32g2"))
print("| `bextdep32p2` |  %5d |  %5.2f |  %5.2f | 2-stage pipeline                          |" % gates("32p2", True))
print("| `bextdep32g1` |  %5d |  %5.2f |  %5.2f | single-stage with GREV support            |" % gates("32g1"))
print("| `bextdep32p1` |  %5d |  %5.2f |  %5.2f | single-stage implementation               |" % gates("32p1", True))
print("| `bextdep32sb` |  %5d |  %5.2f |  %5.2f | 4-cycles sequential implementation        |" % gates("32sb", True))
print("| `bextdep32sn` |  %5d |  %5.2f |  %5.2f | 8-cycles sequential implementation        |" % gates("32sn", True))
print("| `bextdep32sx` |  %5d |  %5.2f |  %5.2f | up-to-32-cycles sequential implementation |" % gates("32sx", True))
print("| `bextdep32go` |  %5d |  %5.2f |  %5.2f | single-stage GREV-only core               |" % gates("32go"))
print("| `vscalealu32` |  %5d |  %5.2f |  %5.2f | ALU from V-Scale CPU (for comparison)     |" % gates("32alu", True))
print()
print("| Name          |   LUTs |    Rel |  Rel+G | Max Freq. |")
print("|:------------- | ------:| ------:| ------:| ---------:|")
print("| `bextdep64g3` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64g3"))
print("| `bextdep64p3` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64p3", True))
print("| `bextdep64g2` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64g2"))
print("| `bextdep64p2` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64p2", True))
print("| `bextdep64g1` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64g1"))
print("| `bextdep64p1` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64p1", True))
print("| `bextdep64sh` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64sh", True))
print("| `bextdep64sb` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64sb", True))
print("| `bextdep64sn` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64sn", True))
print("| `bextdep64sx` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64sx", True))
print("| `bextdep64go` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64go"))
print("| `vscalealu64` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("64alu"))
print()
print("| Name          |   LUTs |    Rel |  Rel+G | Max Freq. |")
print("|:------------- | ------:| ------:| ------:| ---------:|")
print("| `bextdep32g3` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32g3"))
print("| `bextdep32p3` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32p3", True))
print("| `bextdep32g2` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32g2"))
print("| `bextdep32p2` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32p2", True))
print("| `bextdep32g1` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32g1"))
print("| `bextdep32p1` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32p1", True))
print("| `bextdep32sb` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32sb", True))
print("| `bextdep32sn` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32sn", True))
print("| `bextdep32sx` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32sx", True))
print("| `bextdep32go` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32go"))
print("| `vscalealu32` |  %5d |  %5.2f |  %5.2f |  %4d MHz |" % luts("32alu"))
print("| `tinyrocket`  |  %5d |  %5.2f |  ----- |  %4d MHz |" % luts("tinyrocket"))
print()

