import sys
sys.path.extend(['/analysis/michalshaham/PythonProjects/Oceanography'])
from open_data import *
from tools.flow_analysis_tools import radial_profile
from tools.simulation_analysis import Horizontal_SF_calc, Vertical_SF_calc

# data processing
axes = (1, 2)
experiments=['Steady', 'Stochastic']
directions=['Horizontal', 'Vertical']
directions=['Vertical']
filter_width1 = 24
filter_width2 = 14
freq_domain1 = 'LF'  # rot
freq_domain2 = 'HF'  # div
helm = False
helm_domain1 = 'rot'  # rot
helm_domain2 = 'div'  # div
flags_list = [(1, 1, 1), (2, 2, 2), (1, 2, 2), (1, 2, 1), (1, 1, 2), (2, 1, 1), (2, 2, 1), (2, 1, 2)]
# flags1_list = [(1, 1, 1), (2, 1, 2)]


# flags2_list = [(1, 1, 1), (2, 1, 2)]
data_set = TwoDataSets(filt_width1=filter_width1, freq_domain1=freq_domain1, helm1=helm, helm_domain1=helm_domain1,
                       filt_width2=filter_width2, freq_domain2=freq_domain2, helm2=helm, helm_domain2=helm_domain2)


def calc_and_save(data_set, flags, axes, direction, file_name_dir):

    freq = freq_for_fft(1024, dx, 1024, dx)
    if initialize_variable(file_name=file_name_dir, description='decomposition of SF', axes_=('freq',),
                           dimensions=(len(freq),), depth_=depth, freq=freq, freq_str='freq_h'):
        print(direction + ' Flux calc...')
        if direction == 'Horizontal':
            shape, SF_u = Horizontal_SF_calc_data(data_set, flags, 'u', axes, 1)
        elif direction == 'Vertical':
            shape, SF_u = Vertical_SF_calc_data(data_set, flags, 'u', axes, 1)
        _, SF_u = radial_profile(SF_u, shape, dx_shape=dx_shape, axes=axes)

        if direction == 'Horizontal':
            shape, SF_v = Horizontal_SF_calc_data(data_set, flags, 'v', axes, -1)
        elif direction == 'Vertical':
            shape, SF_v = Vertical_SF_calc_data(data_set, flags, 'v', axes, -1)
        _, SF_v = radial_profile(SF_v, shape, dx_shape=dx_shape, axes=axes)

        SF = np.mean(SF_u + SF_v, 0)
        del SF_v, SF_u

        finalize_variable(file_name=file_name_dir, variable=SF, depth_=depth)


def calc_and_save_need_to_test(dat_hor, dat_ver, dat_filtered1, dat_filtered2, depth, axes, flags, flags2, direction, file_name_dir):

    freq = freq_for_fft(1024, dx, 1024, dx)
    if initialize_variable(file_name=file_name_dir, description='decomposition of SF', axes_=('freq',),
                           dimensions=(len(freq),), depth_=depth, freq=freq, freq_str='freq_h'):
        print(direction + ' Flux calc...')
        if direction == 'Horizontal':
            shape, SF_u = Horizontal_SF_calc(dat_hor, dat_ver, dat_filtered1, 'u', axes, 1, flags, dat_hor, dat_ver,
                                             dat_filtered2, flags2)
        elif direction == 'Vertical':
            shape, SF_u = Vertical_SF_calc(dat_ver, dat_filtered1, 'u', axes, 1, flags, dat_ver, dat_filtered2, flags2)
        _, SF_u = radial_profile(SF_u, shape, dx_shape=dx_shape, axes=axes)

        if direction == 'Horizontal':
            shape, SF_v = Horizontal_SF_calc(dat_hor, dat_ver, dat_filtered1, 'v', axes, -1, flags, dat_hor, dat_ver,
                                             dat_filtered2, flags2)
        elif direction == 'Vertical':
            shape, SF_v = Vertical_SF_calc(dat_ver, dat_filtered2, 'v', axes, -1, flags, dat_ver, dat_filtered1, flags2)
        _, SF_v = radial_profile(SF_v, shape, dx_shape=dx_shape, axes=axes)

        SF = np.mean(SF_u + SF_v, 0)
        del SF_v, SF_u

        finalize_variable(file_name=file_name_dir, variable=SF, depth_=depth)

print('vdvkdshkdshkdsajl')
sys.stdout.flush()
depths = get_depths(sys.argv)
depths=[128]
for depth in depths:
    for exp in experiments:
        for flags in flags_list:
            for direction in directions:
                print_start(depth, sys.argv)
                if exp == 'Stochastic' and depth == 77:
                    continue
                data_set.define_datasets(exp=exp, depth=depth)

                file_name_dir = get_SF_file_name(exp, direction, filt1=filter_width1, filt2=filter_width2).format(flags_to_str(flags))
                print(flags)
                print(file_name_dir)
                sys.stdout.flush()

                calc_and_save(data_set, flags, axes, direction, file_name_dir)
                sys.stdout.flush()

print("BYE BYE")
sys.stdout.flush()
