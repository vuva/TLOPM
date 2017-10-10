import sys
import numpy
import argparse
import os
import time

def get_random_time(distribution, parameters):
    if distribution == 'poi':
        return numpy.random.poisson(parameters[0], size=None)
    elif distribution == 'exp':
        return numpy.random.exponential(parameters[0], size=None)
    elif distribution == 'wei':
        return numpy.random.weibull(parameters[0], size=None)
    elif distribution == 'uni':
        return numpy.random.uniform(parameters[0], size=None)
    else:
        return -1

def interface_up(nif):
    # echo vuva | sudo - S
    os.system('sudo iptables -D FORWARD -i '+ nif +' -j DROP')

def interface_down(nif):
    os.system('sudo iptables -A FORWARD -i ' + nif + ' -j DROP')

def main(argv):
    parser = argparse.ArgumentParser(description='Provide distribution and parameters')
    parser.add_argument('-ond', dest='ond',help='Stochastic distribution of the connection time', required=True)
    parser.add_argument('-offd', dest='offd',help='Stochastic distribution of the ourtage time', required=True)
    parser.add_argument('-onp', dest='onParam',type=float, nargs='+', help='Parameter for the distribution',required=True)
    parser.add_argument('-offp', dest='offParam',type=float, nargs='+', help='Parameter for the distribution',required=True)
    parser.add_argument('-i', dest='nif', help='Network interface', required=True)
    args = parser.parse_args()
    print(args)
    try:
        while True:
            interface_up(args.nif)
            onTime = get_random_time(args.ond, args.onParam)
            print(args.nif + ' ON for ' + repr(onTime))
            os.system('cat /sys/class/net/' + args.nif + '/operstate')
            time.sleep(onTime)
            outTime = get_random_time(args.offd, args.offParam)
            interface_down(args.nif)
            print(args.nif + ' OFF for ' + repr(outTime))
            os.system('cat /sys/class/net/' + args.nif + '/operstate')
            time.sleep(outTime)
    except KeyboardInterrupt:
        print('Shutdown requested...exiting')
        interface_up(args.nif)

    sys.exit(0)

if __name__ == "__main__":
    main(sys.argv)

