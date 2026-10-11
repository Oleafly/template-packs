# matlab.py
'''
A Python-MATLAB Interface to "compression" package.
'''
from compression.CompressionCodecs import CompressionCodecs
import numpy as np

def compress(x, shape, k, qTable):
	'''
	Compress an image x through CompressionCodecs
	in package "compression".

	Arguments:
		x -- A flattened 1-D array representing 
			the input image.
		shape -- Original shape of x before being
			flattened.
		k, qTable -- Arguments for Quantization, see 
			QuantizationCodec in compression.Codec
			for further description.
	'''
	# Reshape x back into its original shape.
	x = np.reshape(x, shape, 'F')
	# Reshape qTable back into shape (8, 8).
	qTable = np.reshape(qTable, [8, 8], 'F')
	# Compress the image through CompressionCodecs.
	c = CompressionCodecs(k=k, qTable=qTable)
	y = c.compress(x)
	# Return the compressed image.
	return y
