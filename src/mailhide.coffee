###
 * Provides easy use of the reCAPTCHA Mailhide API.
 * 
 * See:
 * http://www.google.com/recaptcha/mailhide/
 * https://developers.google.com/recaptcha/docs/mailhideapi
###

fs = require 'fs'
crypto = require 'crypto'
querystring = require 'querystring'

class Mailhide
  constructor: (options = {}) ->
    
    if options.privateKeyFile?
      @privateKey = (fs.readFileSync options.privateKeyFile, 'utf8').slice(0,-1)
    else if options.privateKey?
      @privateKey = options.privateKey
    else
      throw new Error 'Specify privateKey or privateKeyFile'
    
    if options.publicKeyFile?
      @publicKey = (fs.readFileSync options.publicKeyFile, 'utf8').slice(0,-1)
    else if options.publicKey?
      @publicKey = options.publicKey
    else
      throw new Error 'Specify privateKey or privateKeyFile'
    
    if options.cipher?
      @cipher = options.cipher
    else
      key = new Buffer @privateKey, 'hex'
      iv = new Buffer '00000000000000000000000000000000', 'hex'
      @cipher = crypto.createCipheriv 'aes-128-cbc', key, iv
  
  url: (email, encoding = 'utf8') ->
    ciphered = ''
    ciphered += @cipher.update email, encoding, 'base64'
    ciphered += @cipher.final 'base64'
    
    cipheredBase64 = ciphered
      .replace(/\+/g, '-')
      .replace(/\//g, '_')
    
    url = 'http://www.google.com/recaptcha/mailhide/d?'
    url += querystring.stringify
      k: @publicKey
      c: cipheredBase64
    
    return url
  
module.exports = Mailhide

