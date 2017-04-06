import Column from '../ui/components/column';
import ColumnLink from '../ui/components/column_link';
import { Link } from 'react-router';
import { defineMessages, injectIntl, FormattedMessage } from 'react-intl';
import { connect } from 'react-redux';
import ImmutablePropTypes from 'react-immutable-proptypes';

const messages = defineMessages({
  heading: { id: 'getting_started.heading', defaultMessage: 'Start' },
  public_timeline: { id: 'navigation_bar.public_timeline', defaultMessage: 'All Known Activity' },
  community_timeline: { id: 'navigation_bar.community_timeline', defaultMessage: 'Local activity' },
  preferences: { id: 'navigation_bar.preferences', defaultMessage: 'Preferences' },
  follow_requests: { id: 'navigation_bar.follow_requests', defaultMessage: 'Accounts Wanting to Follow' },
  sign_out: { id: 'navigation_bar.logout', defaultMessage: 'Sign out' },
  favourites: { id: 'navigation_bar.favourites', defaultMessage: 'Stars' },
  blocks: { id: 'navigation_bar.blocks', defaultMessage: 'Block List' },
  info: { id: 'navigation_bar.info', defaultMessage: 'Additional information' }
});

const mapStateToProps = state => ({
  me: state.getIn(['accounts', state.getIn(['meta', 'me'])])
});

const GettingStarted = ({ intl, me }) => {
  let followRequests = '';

  if (me.get('locked')) {
    followRequests = <ColumnLink icon='users' text={intl.formatMessage(messages.follow_requests)} to='/follow_requests' />;
  }

  return (
    <Column icon='asterisk' heading={intl.formatMessage(messages.heading)}>
      <div style={{ position: 'relative' }}>
        <ColumnLink icon='users' text={intl.formatMessage(messages.community_timeline)} to='/timelines/public/local' />
        <ColumnLink icon='globe' text={intl.formatMessage(messages.public_timeline)} to='/timelines/public' />
        <ColumnLink icon='cog' text={intl.formatMessage(messages.preferences)} href='/settings/preferences' />
        <ColumnLink icon='star' text={intl.formatMessage(messages.favourites)} to='/favourites' />
        {followRequests}
        <ColumnLink icon='ban' text={intl.formatMessage(messages.blocks)} to='/blocks' />
        <ColumnLink icon='book' text={intl.formatMessage(messages.info)} href='/about/more' />
        <ColumnLink icon='sign-out' text={intl.formatMessage(messages.sign_out)} href='/auth/sign_out' method='delete' />
      </div>

      <div className='scrollable optionally-scrollable' style={{ display: 'flex', flexDirection: 'column' }}>
        <div className='static-content getting-started'>
          <p><FormattedMessage id='getting_started.open_source_notice' defaultMessage='Mastodon is \"FOSS\". You can add contributions or log a bug on GitHub at {github}. {apps}.' values={{ github: <a href="https://github.com/tootsuite/mastodon" target="_blank">tootsuite/mastodon</a>, apps: <a href="https://github.com/tootsuite/mastodon/blob/master/docs/Using-Mastodon/Apps.md" target="_blank"><FormattedMessage id='getting_started.apps' defaultMessage='You can find various apps to try' /></a> }} /></p>
        </div>
      </div>
    </Column>
  );
};

GettingStarted.propTypes = {
  intl: React.PropTypes.object.isRequired,
  me: ImmutablePropTypes.map.isRequired
};

export default connect(mapStateToProps)(injectIntl(GettingStarted));
