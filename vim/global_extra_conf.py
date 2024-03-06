def Settings(**kwargs):
    if kwargs['language'] == 'rust':
        return {
            'ls': {
                'rust': {
                    # 'features': ['http2', 'spnego'],
                    'all_features': True,
                    'racer_completion': True,
                    # 'all_targets': False,
                    # 'wait_to_build': 1500,
                }
            }
        }
