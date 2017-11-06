import sys
import numpy
import argparse
import os
import time

TVEC_COMMAND = 'tevc -e spork-join/VPlayGround now '
LOWER_BOUND = 5
def get_random_num(distribution, parameters):
    rannum=-1
    if distribution == 'poi':
        rannum= numpy.random.poisson(parameters[0], size=None)
    elif distribution == 'exp':
        rannum = numpy.random.exponential(float(parameters[0]), size=None)
    elif distribution == 'wei':
        rannum = numpy.random.weibull(parameters[0], size=None)
    elif distribution == 'uni':
        rannum = numpy.random.uniform(parameters[0], size=None)

    if rannum> LOWER_BOUND:
        return rannum
    else:
        return get_random_num(distribution, parameters)


def set_delay(connection, value):
    print(TVEC_COMMAND + connection + ' modify delay=' + repr(value) + 'ms')
    os.system(TVEC_COMMAND + connection + ' modify delay=' + repr(value) + 'ms')

def main(argv):
    parser = argparse.ArgumentParser(description='Provide distribution and parameters')
    parser.add_argument('-i', dest='connection', help='Network connection', required=True)
    parser.add_argument('-d', dest='distribution', help='Changing stochastic distribution', required=True)
    parser.add_argument('-dp', dest='params', help='Changing frequency', nargs='+', required=True)
    parser.add_argument('-l','--latency', dest='latency', nargs='+', help='Set latency')
    parser.add_argument('-pl','--pkloss', dest='pkloss', nargs='+', help='Set packet loss')
    parser.add_argument('-b','--bandwidth', dest='bandwidth', nargs='+', help='Set bandwidth')

    args = parser.parse_args()
    print(args)
    latency_dis=None
    if (args.latency is not None):
        latency_dis= args.latency.pop(0)
    try:
        while True:
            inter_mod_time = get_random_num(args.distribution, args.params)
            print(inter_mod_time)
            if latency_dis is not None:
                new_latency = get_random_num(latency_dis, args.latency)
                set_delay(args.connection, new_latency)
            time.sleep(inter_mod_time)
    except KeyboardInterrupt:
        print('Shutdown requested...exiting')


    sys.exit(0)

if __name__ == "__main__":
    main(sys.argv)

